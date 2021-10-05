//
//  Vibration.swift
//  Biniva
//
//  Created by Nick Oltyan on 05.10.2021.
//

import UIKit


class Vibration {
    
    static func soft() -> Void{
        let soft = UIImpactFeedbackGenerator(style: .soft)
        soft.impactOccurred()
    }
    
    static func light() -> Void{
        let light = UIImpactFeedbackGenerator(style: .light)
        light.impactOccurred()
    }
    
    static func medium() -> Void{
        let medium = UIImpactFeedbackGenerator(style: .medium)
        medium.impactOccurred()
    }
    
    
    static func Heavy() -> Void{
        let heavy = UIImpactFeedbackGenerator(style: .heavy)
        heavy.impactOccurred()
    }
}
