//
//  Material Defaults.swift
//  GreenerCo
//
//  Created by Никита Олтян on 13.02.2021.
//

import Foundation
import UIKit

class MaterialDefaults {
    
    static func LinearFunction(viewSize size: CGFloat, addedSize add: Int) -> CGFloat {
        switch size {
        case 400:
            return CGFloat(add) * 0.26
        default:
            return CGFloat(add) * 0.24
        }
    }
    
    
    static func GetTextColor(alreadyLogged logged: Int) -> UIColor {
        switch logged {
        case 0...120:
            return MainConstants.nearBlack
        default:
            return MainConstants.white
        }
    }
    
    
    static func YForDashedLine(dailyNorm norm: Int) -> CGFloat {
        switch MainConstants.screenHeight {
        case 700...:
            let lineBottom: CGFloat = LinearFunction(viewSize: 400, addedSize: norm)
            return 400 - lineBottom
        default:
            let lineBottom: CGFloat = LinearFunction(viewSize: 360, addedSize: norm)
            return 360 - lineBottom
        }
    }
    
}
