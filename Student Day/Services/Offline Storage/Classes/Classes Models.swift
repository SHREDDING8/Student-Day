//
//  Classes Models.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation
import RealmSwift


class ClassDaysRealm: EmbeddedObject {
    @Persisted var monday: Bool = false
    @Persisted var tuesday: Bool = false
    @Persisted var wednesday: Bool = false
    @Persisted var thursday: Bool = false
    @Persisted var friday: Bool = false
    @Persisted var saturday: Bool = false
    @Persisted var sunday: Bool = false
    
    convenience init(monday: Bool, tuesday: Bool, wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, sunday: Bool) {
        self.init()
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
}

enum ClassReminderRealm:String, PersistableEnum {
    case none
    case minute5
    case minute15
    case minute30
    case hour1
    case hour2
    case day1
    case day2
    case week1
}

class ClassRealm: Object{
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var title:String
    @Persisted var teacher:String
    @Persisted var type:String
    @Persisted var startTime:Date
    @Persisted var endTime:Date
    @Persisted var place:String
    @Persisted var backgroundColor:String
    @Persisted var days:ClassDaysRealm?
    @Persisted var reminder:ClassReminderRealm = .none
    
    
    convenience init(title: String, teacher:String, type:String, startTime:Date, endTime:Date, place:String, backgroundColor:String, days:ClassDaysRealm, reminder:ClassReminderRealm) {
        self.init()
        self.title = title
        self.teacher = teacher
        self.type = type
        self.startTime = startTime
        self.endTime = endTime
        self.place = place
        self.backgroundColor = backgroundColor
        self.days = days
        self.reminder = reminder
    }
}
