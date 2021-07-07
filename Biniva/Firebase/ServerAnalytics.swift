//
//  Analytics.swift
//  Biniva
//
//  Created by Никита Олтян on 07.07.2021.
//

import Firebase

class ServerAnalytics {
    /// Initiates when user the first time open the app.
    func logStartOnboarding() {
        Analytics.logEvent(AnalyticsEventTutorialBegin, parameters: [:])
    }
    
    /// Initiates when user tap "finish" button during onboarding.
    func logFinishOnboarding() {
        Analytics.logEvent(AnalyticsEventTutorialComplete, parameters: [:])
    }
    
    /// Initiates when user complited adding materials.
    func logAddMaterial(type: Int, size: Int) {
        Analytics.logEvent("add_material", parameters: [
            "type": type,
            "size": size
        ])
    }
    
    /// Initiates when user tap on Map selector on the top Sliding View.
    func logOpenMap() {
        Analytics.logEvent("open_map", parameters: [:])
    }
    
    /// Initiates when user comlited adding new Point.
    func logAddPoint() {
        Analytics.logEvent("point_add", parameters: [:])
    }
    
    /// Initiates when user taped on new Point on the map.
    func logPointTap() {
        Analytics.logEvent("point_tap", parameters: [:])
    }
}
