//
//  ClassesComponentsStorageService.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import Foundation
import RealmSwift

protocol ClassesComponentsStorageServiceProtocol{
    var realm:Realm { get }
    func writeNewConpmnent(component:String)
    func getAllComponents()->[String]
    func deleteComponent(index:Int)
    
}

class ClassesTitleStorageService:ClassesComponentsStorageServiceProtocol{
    var realm = try! Realm()
    
    func writeNewConpmnent(component: String) {
        let newTitle = ClasseTitleRealm(title: component)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.add(newTitle)
            })
        }
    }
    
    func getAllComponents() -> [String] {
        let titlesRealm = realm.objects(ClasseTitleRealm.self)
        var titlesString:[String] = []
        for title in titlesRealm{
            titlesString.append(title.title)
        }
        return titlesString
    }
    
    func deleteComponent(index:Int){
        let titlesRealm = realm.objects(ClasseTitleRealm.self)
        
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.delete(titlesRealm[index])
            })
        }
    }
    
}


class ClassesTeacherStorageService:ClassesComponentsStorageServiceProtocol{
    var realm = try! Realm()
    
    func writeNewConpmnent(component: String) {
        let newTecher = ClasseTeacherRealm(teacher: component)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.add(newTecher)
            })
        }
    }
    
    func getAllComponents() -> [String] {
        let teachers = realm.objects(ClasseTeacherRealm.self)
        var result:[String] = []
        for teacher in teachers{
            result.append(teacher.teacher)
        }
        return result
    }
    
    func deleteComponent(index: Int) {
        let teachers = realm.objects(ClasseTeacherRealm.self)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.delete(teachers[index])
            })
        }
    }
    
    
}

class ClassesTypeStorageService:ClassesComponentsStorageServiceProtocol{
    var realm = try! Realm()
    
    func writeNewConpmnent(component: String) {
        let newType = ClasseClassTypeRealm(type: component)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.add(newType)
            })
        }
    }
    
    func getAllComponents() -> [String] {
        let types = realm.objects(ClasseClassTypeRealm.self)
        var result:[String] = []
        for type in types{
            result.append(type.type)
        }
        return result
    }
    
    func deleteComponent(index: Int) {
        let types = realm.objects(ClasseClassTypeRealm.self)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.delete(types[index])
            })
        }
    }
    
}

class ClassesPlaceStorageService:ClassesComponentsStorageServiceProtocol{
    var realm = try! Realm()
    
    func writeNewConpmnent(component: String) {
        let newPlace = ClassePlaceRealm(place: component)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.add(newPlace)
            })
        }
    }
    
    func getAllComponents() -> [String] {
        let places = realm.objects(ClassePlaceRealm.self)
        var result:[String] = []
        for place in places{
            result.append(place.place)
        }
        return result
    }
    
    func deleteComponent(index: Int) {
        let places = realm.objects(ClassePlaceRealm.self)
        DispatchQueue.main.async {
            try! self.realm.write({
                self.realm.delete(places[index])
            })
        }
    }
    
}
