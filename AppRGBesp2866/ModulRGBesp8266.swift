//
//  ModelRGBesp8266.swift
//  AppRGBesp2866
//
//  Created by Дмитрий Шикунов on 11.04.2021.
//

import Foundation

enum LedState {
    case off
    case on
    case blink
}

enum Led {
    case Red
    case Green
    case Blue
}

class ModulRGB {
    var ledRed: LedState = .off
    var ledGreen: LedState = .off
    var ledBlue: LedState = .off
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }

    func toSwitch(led: Led, state: LedState)  {
        switch led {
            case .Red:
                ledRed = state
            case .Green:
                ledGreen = state
            case .Blue:
                ledBlue = state
        }
    }
        
    private func getLedState(led: Led) -> LedState {
        switch led {
            case .Red:
                return ledRed
            case .Green:
                return ledGreen
            case .Blue:
                return ledBlue
        }
    }
    
    func getLedName(led: Led) -> String {
        switch led {
            case .Red:
                return "led2"
            case .Green:
                return "led3"
            case .Blue:
                return "led1"
        }

    }
    
    func getRequestForCommand(led: Led) -> String {
        let ledStateNow = getLedState(led: led)
        var ledCommandNeed: String
        if ledStateNow == .on {
            ledCommandNeed = "off"
        } else {
            ledCommandNeed = "on"
        }

        return urlString + getLedName(led: led) + ledCommandNeed
    }
}
