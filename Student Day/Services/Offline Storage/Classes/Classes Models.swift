//
//  Classes Models.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation
import RealmSwift

class ClassRealm: Object{
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var className:String
    
    convenience init(className: String) {
        self.init()
        self.className = className
    }
}
