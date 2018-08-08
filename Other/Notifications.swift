//
//  Notifications.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 8/1/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications {
    static func setUpNotification1() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Today is a great day to use public transportation!"
        
        var date = DateComponents()
        date.weekday = 1
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    static func setUpNotification2() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Do not consume red meat :)"
        
        var date = DateComponents()
        date.weekday = 2
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    static func setUpNotification3() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Don't buy plastic bottles, bring one from home!"
        
        var date = DateComponents()
        date.weekday = 3
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    static func setUpNotification4() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Today is a great day not to use AC, open the windows!"
        
        var date = DateComponents()
        date.weekday = 4
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    static func setUpNotification5() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Carpool with a friend"
        
        var date = DateComponents()
        date.weekday = 5
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    static func setUpNotification6() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Shower ASAP"
        
        var date = DateComponents()
        date.weekday = 6
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    static func setUpNotification7() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Challenge of the day"
        notificationContent.body = "Say no to straws! Save the turtles"
        
        var date = DateComponents()
        date.weekday = 7
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "identifier", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
