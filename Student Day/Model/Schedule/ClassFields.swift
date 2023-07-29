//
//  ClassFields.swift
//  Student Day
//
//  Created by SHREDDING on 06.04.2023.
//

import Foundation

enum ClassFieldType:String {
    case subject = "subject"
    case teacher = "Teacher"
    case place = "Place"
    case classType = "ClassType"
}

class ClassField{
    let classFieldType:ClassFieldType
    var classFieldDocumentId:String?
    let ClassFieldText:String
    
    init(classFieldType: ClassFieldType, classFieldDocumentId: String, ClassFieldText: String) {
        self.classFieldType = classFieldType
        self.classFieldDocumentId = classFieldDocumentId
        self.ClassFieldText = ClassFieldText
    }
    
    init(classFieldType: ClassFieldType, ClassFieldText: String) {
        self.classFieldType = classFieldType
        self.ClassFieldText = ClassFieldText
    }
    
}
