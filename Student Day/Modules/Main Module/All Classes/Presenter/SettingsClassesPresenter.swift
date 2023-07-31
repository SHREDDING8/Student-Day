//
//  SettingsClassesPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 28.07.2023.
//

import Foundation
import RealmSwift


protocol SettingsClassesProtocol:AnyObject{
}

protocol SettingsClassesPresenterProtocol:AnyObject{
    var classes:Results<ClassRealm>! { get }
    
    init(view:SettingsClassesProtocol)
    
    func getClassesCount()->Int
    func getAllClasses()
    
}
class SettingsClassesPresenter:SettingsClassesPresenterProtocol{
    weak var view:SettingsClassesProtocol?
    let classesStorageService = ClassesStorageService()
    var classes:Results<ClassRealm>!
    
    
    required init(view:SettingsClassesProtocol) {
        self.view = view
    }
    
    func getClassesCount()->Int{
        return classes.count
    }
    
    func getAllClasses(){
        classes = classesStorageService.getAllClasses()
        print(classes[0].backgroundColor)
    }
}
