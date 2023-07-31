//
//  Classes Components Models.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import Foundation
import RealmSwift

class ClasseTitleRealm: Object{
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var title:String
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}

class ClasseTeacherRealm: Object{
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var teacher:String
    
    convenience init(teacher: String) {
        self.init()
        self.teacher = teacher
    }
}

class ClasseClassTypeRealm: Object{
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var type:String
    
    convenience init(type: String) {
        self.init()
        self.type = type
    }
}

class ClassePlaceRealm: Object{
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var place:String
    
    convenience init(place: String) {
        self.init()
        self.place = place
    }
}
