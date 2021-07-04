//
//  Notifications.swift
//  Biniva
//
//  Created by Nick Oltyan on 03.07.2021.
//

import NotificationCenter

class Notifications {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization(completion: @escaping(_ success: Bool) -> Void){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if didAllow {
                self.setUpLocalNotifications(completion: { (_) in
                    completion(true)
                })
            } else {
                print("User has declined notifications")
                completion(false)
            }
        }
    }
    
    func setUpLocalNotifications(completion: @escaping(_ success: Bool) -> Void){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Как прошел твой день?"
        notificationContent.body = "Добавь свой мусор за сегодня, сделай мир чуточку зеленее!"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
                        
        var datComp = DateComponents()
        datComp.hour = 20
        datComp.minute = 01
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "ID", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
                completion(false)
            }
            completion(true)
        }
    }
}
