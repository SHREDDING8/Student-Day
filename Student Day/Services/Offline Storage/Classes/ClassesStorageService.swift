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
    
    func writeNewClass(newClass:ClassRealm)
    func getAllClasses()->Results<ClassRealm>
    
}

class ClassesStorageService:ClassesStorageServiceProtocol{
    
    var realm = try! Realm()
    
    func writeNewClass(newClass:ClassRealm) {
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.add(newClass)
            }
        }
    }
    
    func getAllClasses()->Results<ClassRealm>{
        let classes = realm.objects(ClassRealm.self)
        return classes
    }
    
}
