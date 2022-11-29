//
//  Notifications.swift
//  Student Day
//
//  Created by SHREDDING on 28.11.2022.
//

import Foundation
import UserNotifications
import UIKit

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

let remiderArray = [
"Не напоминать",
"Напомнить за 5 минут",
"Напомнить за 15 минут",
"Напомнить за 30 минут",
"Напомнить за 1 час",
"Напомнить за 2 часа",
"Напомнить за 1 день",
"Напомнить за 2 дня",
"Напомнить за 1 неделю",
]

public class Notifications: NSObject, UNUserNotificationCenterDelegate{
    
    let identifer:String
    let notificationCenter = UNUserNotificationCenter.current()
    
    init(identifer: String) {
        self.identifer = identifer
    }
    
    public func scheduleNotifications(className:String, timeBeforeClass:String,time:Date,weekDayClass: Int){
        
        let timeBeforeClassSplitted = timeBeforeClass.split(separator: " ")
        let sizeTimeBeforeClassSplitted = timeBeforeClassSplitted.count
        
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "\(className) начнётся через \(timeBeforeClassSplitted[sizeTimeBeforeClassSplitted - 2]) \(timeBeforeClassSplitted[sizeTimeBeforeClassSplitted - 1])"
        content.sound = .default
        
        let dateClass = createDateOfNotificationBeforeClass(timeClass: time, weekDayClass: weekDayClass,timeBeforeClass: Int(timeBeforeClassSplitted[sizeTimeBeforeClassSplitted - 2])!,typeAdd: String(timeBeforeClassSplitted[sizeTimeBeforeClassSplitted - 1]))
        print(dateClass)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: dateClass), repeats: true)
        
        let request = UNNotificationRequest(identifier: identifer, content: content, trigger: trigger)
        
        self.notificationCenter.add(request)
    }
    
    public func removeNotifications(){
        do{
            self.notificationCenter.removeDeliveredNotifications(withIdentifiers: [self.identifer])
        }
        
    }
    
    
    private func createDateOfNotificationBeforeClass(timeClass:Date, weekDayClass:Int, timeBeforeClass:Int, typeAdd:String)->Date{
        // Function for create a date of notification
        // it takes current date and by adding some values gets the
        // needed date
        
        let weekDayDigitTimeClass = timeClass.formatted(.dateTime .weekday(.oneDigit))
        var weekDayDigit = 0
        
        if Int(weekDayDigitTimeClass) == 0{
            weekDayDigit = 6
        }else{
            weekDayDigit = Int(weekDayDigitTimeClass)! - 1
        }
        
        
        let adding_days = weekDayClass - weekDayDigit
        
        
        var DateOfClass = Calendar.current.date(byAdding: DateComponents(day: adding_days), to: timeClass)
        
        if typeAdd == "минут"{
            DateOfClass = Calendar.current.date(byAdding: DateComponents(minute: -timeBeforeClass), to: DateOfClass!)
        }else if (typeAdd.contains("час")){
            DateOfClass = Calendar.current.date(byAdding: DateComponents(hour: -timeBeforeClass), to: DateOfClass!)
        }else if (typeAdd.contains("день") || typeAdd.contains("дня")){
            DateOfClass = Calendar.current.date(byAdding: DateComponents(day: -timeBeforeClass), to: DateOfClass!)
        }else if (typeAdd.contains("неделю")){
            DateOfClass = Calendar.current.date(byAdding: DateComponents(day: -6), to: DateOfClass!)
        }
        
        
        return DateOfClass!
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.badge,.banner])
    }
}
