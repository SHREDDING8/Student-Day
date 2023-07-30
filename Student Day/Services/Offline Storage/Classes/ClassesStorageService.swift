//
//  ClassesStorageService.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation
import RealmSwift

protocol ClassesStorageServiceProtocol{
    var realm:Realm { get }
    
    func writeNewClass()
    func getAllClasses()->Results<ClassRealm>
    
}

class ClassesStorageService:ClassesStorageServiceProtocol{
    
    var realm = try! Realm()
    
    func writeNewClass() {
        let days = ClassDaysRealm(monday: false, tuesday: true, wednesday: false, thursday: false, friday: false, saturday: false, sunday: false)
        
        let newClass = ClassRealm(title: "Hello", teacher: "World", type: "type", startTime: Date.now, endTime: Date.now, place: "place", days: days, reminder: .day1)
        
        try! realm.write {
            realm.add(newClass)
        }
    }
    
    func getAllClasses()->Results<ClassRealm>{
        let classes = realm.objects(ClassRealm.self)
        return classes
    }
    
}
