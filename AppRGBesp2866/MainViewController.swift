//
//  ViewController.swift
//  AppRGBesp2866
//
//  Created by Дмитрий Шикунов on 10.04.2021.

import UIKit

struct LedsModulRGBState: Codable {
    var led1: String
    var led2: String
    var led3: String
    
    enum CodingKeys: String, CodingKey {
        case led1 = "LED1"
        case led2 = "LED2"
        case led3 = "LED3"
    }
}

class MainViewController: UIViewController {

    let rootView = MainView()
    var esp2866RGB = ModulRGB(urlString: "http://192.168.1.1/")
    var openTransaction: Bool = false
    
    init() {
        super.init(nibName: .none, bundle: .none)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        rootView.redButton.addTarget(self, action: #selector(redButtonDidTap), for: .touchUpInside)
        rootView.greenButton.addTarget(self, action: #selector(greenButtonDidTap), for: .touchUpInside)
        rootView.blueButton.addTarget(self, action: #selector(blueButtonDidTap), for: .touchUpInside)
        
    }
    
    override func loadView() {
        self.view = rootView
    }

    func setup() {

    }
    
    func refreshAll () {
        rootView.refreshView(modulRGB: esp2866RGB)
    }
    
    @objc func redButtonDidTap() {
        self.openTransaction = true
        sendLedCommandToESP8266(led: .Red)
        
        while self.openTransaction {}
        refreshAll()
        
    }
    
    @objc func greenButtonDidTap() {
        self.openTransaction = true
        sendLedCommandToESP8266(led: .Green)
        
        while self.openTransaction {}
        refreshAll()

    }
    
    @objc func blueButtonDidTap() {
        self.openTransaction = true
        sendLedCommandToESP8266(led: .Blue)
        
        while self.openTransaction {}
        
        refreshAll()

    }
    
    func sendLedCommandToESP8266 (led: Led) {
        let urlString = esp2866RGB.getRequestForCommand(led: led)
        debugPrint(urlString)
        guard let url = URL(string: urlString) else {
            debugPrint("URL адрес не корректен.")
            return
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let inputData = data else {
                debugPrint("Data не получена")
                return
            }
                        
            let decoder = JSONDecoder()
            let ledsModulRGBState = try? decoder.decode(LedsModulRGBState.self, from: inputData)
            debugPrint("Результат парсинга \(String(describing: ledsModulRGBState)))")
            debugPrint("Результат парсинга LED1\(String(describing: ledsModulRGBState?.led1)))")
            debugPrint("Результат парсинга LED2\(String(describing: ledsModulRGBState?.led2)))")
            debugPrint("Результат парсинга LED3\(String(describing: ledsModulRGBState?.led3)))")
            
            if ledsModulRGBState?.led2.uppercased() == "ON" {
                self.esp2866RGB.toSwitch(led: .Red, state: .on)
            } else {
                self.esp2866RGB.toSwitch(led: .Red, state: .off)
            }
            
            if ledsModulRGBState?.led3.uppercased() == "ON" {
                self.esp2866RGB.toSwitch(led: .Green, state: .on)
            } else {
                self.esp2866RGB.toSwitch(led: .Green, state: .off)
            }

            if ledsModulRGBState?.led1.uppercased() == "ON" {
                self.esp2866RGB.toSwitch(led: .Blue, state: .on)
            } else {
                self.esp2866RGB.toSwitch(led: .Blue, state: .off)
            }
            
            self.openTransaction = false
        }
        task.resume()
    }
}

