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
        let newClass = ClassRealm(className: "Some Class")
        try! realm.write {
            realm.add(newClass)
        }
    }
    
    func getAllClasses()->Results<ClassRealm>{
        let classes = realm.objects(ClassRealm.self)
        return classes
    }
    
}
