//
//  NewClassModel.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation

class NewClassModel{
    
    struct Day{
        var title:String
        var isSelected:Bool
    }
    
    public enum ReminderEnum: Equatable{
        case none
        case minute5
        case minute15
        case minute30
        case hour1
        case hour2
        case day1
        case day2
        case week1
        
        init(index:Int){
            switch index{
            case 0:
                self = .none
            case 1:
                self = .minute5
            case 2:
                self = .minute15
            case 3:
                self = .minute30
            case 4:
                self = .hour1
            case 5:
                self = .hour2
            case 6:
                self = .day1
            case 7:
                self = .day2
            case 8:
                self = .week1
            default:
                self = .none
            }
        }
        
        func getString()->String{
            switch self {
            case .none:
                return "Не напоминать"
            case .minute5:
                return "Напомнить за 5 минут"
            case .minute15:
                return "Напомнить за 15 минут"
            case .minute30:
                return "Напомнить за 30 минут"
            case .hour1:
                return "Напомнить за 1 час"
            case .hour2:
                return "Напомнить за 2 часа"
            case .day1:
                return "Напомнить за 1 день"
            case .day2:
                return "Напомнить за 2 дня"
            case .week1:
                return "Напомнить за 1 неделю"
            }
        }
        func getIndex()->Int{
            switch self {
            case .none:
                return 0
            case .minute5:
                return 1
            case .minute15:
                return 2
            case .minute30:
                return 3
            case .hour1:
                return 4
            case .hour2:
                return 5
            case .day1:
                return 6
            case .day2:
                return 7
            case .week1:
                return 8
            }
        }
        
        func toRealm()->ClassReminderRealm{
            switch self {
            case .none:
                return .none
            case .minute5:
                return .minute5
            case .minute15:
                return .minute15
            case .minute30:
                return .minute30
            case .hour1:
                return .hour1
            case .hour2:
                return .hour2
            case .day1:
                return .day1
            case .day2:
                return .day2
            case .week1:
                return .week1
            }
        }
    }
    
    var title:String?
    var teacher:String?
    var type:String?
    var startTime:Date?
    var endTime:Date?
    var place:String?
    var currentReminder:ReminderEnum = .none
    
    var backgroundColor:String?
    
    
    var days:[Day] = [
        Day(title: "Понедельник", isSelected: false),
        Day(title: "Вторник", isSelected: false),
        Day(title: "Среда", isSelected: false),
        Day(title: "Четверг", isSelected: false),
        Day(title: "Пятница", isSelected: false),
        Day(title: "Суббота", isSelected: false),
        Day(title: "Воскресенье", isSelected: false)
    ]
    
    func validateForSave()->Bool{
        if title == nil || startTime == nil || endTime == nil || backgroundColor == nil{
            return false
        }
        
        for day in days{
            if day.isSelected == true{
                return true
            }
        }
        
        return false
    }
    
    func toRealmModel()->ClassRealm{
        
        let daysRealm = ClassDaysRealm(
            monday: days[0].isSelected,
            tuesday: days[1].isSelected,
            wednesday: days[2].isSelected,
            thursday: days[3].isSelected,
            friday: days[4].isSelected,
            saturday: days[5].isSelected,
            sunday: days[6].isSelected
        )
        
        
        
        let classRealm = ClassRealm(
            title: self.title ?? "",
            teacher: self.teacher ?? "",
            type: self.type ?? "",
            startTime: self.startTime ?? Date.now,
            endTime: self.endTime ?? Date.now,
            place: self.place ?? "",
            backgroundColor: self.backgroundColor ?? "",
            days: daysRealm,
            reminder: currentReminder.toRealm()
        )
        
        return classRealm
    }
    
}
