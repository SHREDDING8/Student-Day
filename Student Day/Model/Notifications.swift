//
//  Notifications.swift
//  Student Day
//
//  Created by SHREDDING on 28.11.2022.
//

import Foundation
import UserNotifications
import UIKit

// MARK: - CONSTANTS

// enum with possible notifications
enum notificationTimeBefore:String{
    case none = "Не напоминать"
    case minute5 = "Напомнить за 5 минут"
    case minute15 = "Напомнить за 15 минут"
    case minute30 = "Напомнить за 30 минут"
    case hour1 = "Напомнить за 1 час"
    case hour2 = "Напомнить за 2 часа"
    case day1 = "Напомнить за 1 день"
    case day2 = "Напомнить за 2 дня"
    case week1 = "Напомнить за 1 неделю"
    
}

// Dict with possible notifications
public let remiderDict = [
    
    "Не напоминать": (0,0),
    "Напомнить за 5 минут": (1,5),
    "Напомнить за 15 минут": (2,15),
    "Напомнить за 30 минут": (3,30),
    "Напомнить за 1 час": (4,1),
    "Напомнить за 2 часа": (5,2),
    "Напомнить за 1 день": (6,1),
    "Напомнить за 2 дня": (7,2),
    "Напомнить за 1 неделю": (8,1)
]

// MARK: - Class Notifications

public class Notifications: NSObject{
    // identifer of notification (name Of Class)
    let identifer:String
    let notificationCenter = UNUserNotificationCenter.current()
    
    init(identifer: String) {
        self.identifer = identifer
    }
    
    /**
     This function create local notification for class/Course in schedule
     
     
     **parameters:**
        - className: Name of user Class/Course
        - timeBeforeClass: What time before notification need show
        - time: time of Class/Course
        - weekDayClass: Week day of user Class/Course
     */
    public func scheduleNotifications(className:String, timeBeforeClass:String,time:Date,weekDayClass: Int){
        
        let timeBeforeClassSplitted = timeBeforeClass.split(separator: " ")
        guard let timeBeforeClassEnum = notificationTimeBefore(rawValue: timeBeforeClass) else { return }
        // size of array
        let sizeTimeBeforeClassSplitted = timeBeforeClassSplitted.count
        
        // notification content
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "\(className) начнётся через \(timeBeforeClassSplitted[sizeTimeBeforeClassSplitted - 2]) \(timeBeforeClassSplitted[sizeTimeBeforeClassSplitted - 1])"
        content.sound = .default
        
        let dateClass = createDateOfNotificationBeforeClass(timeClass: time, weekDayClass: weekDayClass,timeBeforeClass: timeBeforeClassEnum)
        
        // notification trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: dateClass), repeats: true)
        
        let request = UNNotificationRequest(identifier: identifer, content: content, trigger: trigger)
        
        self.notificationCenter.add(request)
    }
    
    /**
     Remove notification from notification center
     
     */
    public func removeNotifications(){
        do{
            self.notificationCenter.removeDeliveredNotifications(withIdentifiers: [self.identifer])
        }
        
    }
    
    /**
     this function create a date that means start of notifications for Class/Course in schedule
     
     
     **parameters:**
     - timeClass: description
     - weekDayClass:
     - timeBeforeClass:
     - typeAdd:
     */
    private func createDateOfNotificationBeforeClass(timeClass:Date, weekDayClass:Int, timeBeforeClass:notificationTimeBefore)->Date{
        
        // getting week day of Class/Course
        let weekDayDigitTimeClass = timeClass.formatted(.dateTime .weekday(.oneDigit))
        var weekDayDigit = 0
        
        // shifting weekday
        if Int(weekDayDigitTimeClass) == 0{
            weekDayDigit = 6
        }else{
            weekDayDigit = Int(weekDayDigitTimeClass)! - 1
        }
        
        
        let adding_days = weekDayClass - weekDayDigit
        
        // adding days minutes hours etc.. for starting notification
        var DateOfClass = Calendar.current.date(byAdding: DateComponents(day: adding_days), to: timeClass)
        
        switch timeBeforeClass {
        case .none:
            break;
        case .minute5,.minute15,.minute30:
            DateOfClass = Calendar.current.date(byAdding: DateComponents(minute: -remiderDict[timeBeforeClass.rawValue]!.1), to: DateOfClass!)
        case .hour1,.hour2:
            DateOfClass = Calendar.current.date(byAdding: DateComponents(hour: -remiderDict[timeBeforeClass.rawValue]!.1), to: DateOfClass!)
        case .day1,.day2:
            DateOfClass = Calendar.current.date(byAdding: DateComponents(day: -remiderDict[timeBeforeClass.rawValue]!.1), to: DateOfClass!)
        case .week1:
            DateOfClass = Calendar.current.date(byAdding: DateComponents(day: -6), to: DateOfClass!)
        }
        
        return DateOfClass!
    }
    
    
}

// MARK: - Notification Delegate
extension Notifications:UNUserNotificationCenterDelegate{
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.badge,.banner])
    }
}
