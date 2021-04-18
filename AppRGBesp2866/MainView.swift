//
//  MainView.swift
//  AppRGBesp2866
//
//  Created by Дмитрий Шикунов on 10.04.2021.
//

import UIKit
import SnapKit

class MainView: UIView {

    var buttonStackView: UIStackView!
    var redButton: UIButton!
    var greenButton: UIButton!
    var blueButton: UIButton!
 
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshView(modulRGB: ModulRGB) {
        if modulRGB.ledRed == .on {
            redButton.backgroundColor = .systemRed
        } else {
            redButton.backgroundColor = .gray
        }
 
        if modulRGB.ledGreen == .on {
            greenButton.backgroundColor = .systemGreen
        } else {
            greenButton.backgroundColor = .gray
        }

        if modulRGB.ledBlue == .on {
            blueButton.backgroundColor = .systemBlue
        } else {
            blueButton.backgroundColor = .gray
        }
   }
    
    func setup()  {
        backgroundColor = .darkGray
        
        buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 40
        buttonStackView.distribution = .fillEqually
        addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
        }

        redButton = UIButton()
        redButton.setTitle("R", for: .normal)
        redButton.titleLabel?.font = .systemFont(ofSize: 50)
        redButton.setTitleColor(.white, for: .normal)
        redButton.backgroundColor = .gray
        redButton.layer.cornerRadius = 50
        
        buttonStackView.addArrangedSubview(redButton)
        
        redButton.snp.makeConstraints { make in
            make.height.equalTo(100).priority(.required)
        }
        
        greenButton = UIButton()
        greenButton.setTitle("G", for: .normal)
        greenButton.titleLabel?.font = .systemFont(ofSize: 50)
        
        greenButton.setTitleColor(.white, for: .normal)
        greenButton.backgroundColor = .gray
        greenButton.layer.cornerRadius = 50
        
        buttonStackView.addArrangedSubview(greenButton)
        
        greenButton.snp.makeConstraints { make in
            make.height.equalTo(100).priority(.required)
        }
        
        blueButton = UIButton()
        blueButton.setTitle("B", for: .normal)
        blueButton.titleLabel?.font = .systemFont(ofSize: 50)
        
        blueButton.setTitleColor(.white, for: .normal)
        blueButton.backgroundColor = .gray
        blueButton.layer.cornerRadius = 50
        
        buttonStackView.addArrangedSubview(blueButton)
        
        blueButton.snp.makeConstraints { make in
            make.height.equalTo(100).priority(.required)
        }
    }
}
