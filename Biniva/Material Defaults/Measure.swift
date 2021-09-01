//
//  Measure.swift
//  Biniva
//
//  Created by Nick Oltyan on 08.08.2021.
//

import UIKit

class Measure {
    
    
    enum neededMeasurementType {
        case kilogramm
        case gramm
    }
    
    
    /// Return string with the right measurement style. It defines Kg/Lb automatically.
    /// - parameter weight: in gramms
    /// - parameter type: kilograms or gramms
    /// - returns: A string with weight and proper weight symbol.
    func getMeasurementString(weight: Int, forNeededType type: neededMeasurementType) -> String {
        switch type {
        case .kilogramm:
            return getForKilograms(weight: weight)
        case .gramm:
            return getForGramms(weight: weight)
        }
    }
    
    /// For AddTrashView cell selection prepare gramms data to performing in WeightView.
    func getOzForGramms(gramms: Int) -> Double {
        let oz = Double(gramms)/28.35
        return oz.rounded(toPlaces: 1)
    }
    
    /// For AddTrashController  prepare oz data to saving as Int Gramms.
    func getGrammsForOz(oz: Double) -> Int {
        let rounded: Double = round(oz * 28.35)
        return Int(rounded)
    }
    
    
    private
    func getForKilograms(weight: Int) -> String {
        switch Defaults.getWeightSystem() {
        case 0:
            let formatted = String(format: "%.2f", Double(weight)/1000.0) // Kg
            let weightMeasure: String = NSLocalizedString("weight_measurement_kilograms", comment: "Localized kg measurement")
            return "\(formatted) \(weightMeasure)"
        case 1:
            let formatted = String(format: "%.2f", Double(weight)/453.9) // lb
            let weightMeasure: String = NSLocalizedString("weight_measurement_pounds", comment: "Localized lb measurement")
            return "\(formatted) \(weightMeasure)"
        default: // For error types. But they shouldn't be.
            return "NaN data"
        }
    }
    
    private
    func getForGramms(weight: Int) -> String {
        switch Defaults.getWeightSystem() {
        case 0:
            let weightMeasure: String = NSLocalizedString("weight_measurement_gramms", comment: "Localized g measurement") // g
            return "\(weight) \(weightMeasure)"
        case 1:
            let formatted = String(format: "%.1f", Double(weight)/28.35) // oz
            let weightMeasure: String = NSLocalizedString("weight_measurement_ounces", comment: "Localized oz measurement")
            return "\(formatted) \(weightMeasure)"
        default: // For error types. But they shouldn't be.
            return "NaN data"
        }
    }
}
