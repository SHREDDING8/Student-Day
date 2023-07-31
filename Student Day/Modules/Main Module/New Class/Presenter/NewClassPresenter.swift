//
//  NewClassPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 29.07.2023.
//

import Foundation


protocol NewClassViewProtocol:AnyObject{
    func setReminderString(reminderString:String)
    func setTitleString(title:String)
    func setTeacherString(teacherString:String)
    func setTypeString(typeString:String)
    func setPlaceString(placeString:String)
    
    
    
    func showErrorSave()
    func succsessfullSave()
}

protocol NewClassPresenterProtocol:AnyObject{
    init(view:NewClassViewProtocol, model:NewClassModel, storage:ClassesStorageServiceProtocol)
    
    func saveClass()
    
    func setBackgroundColor(hex:String)
    
    func getReminderString()
    func getTitleString()
    func getTeacherString()
    func getTypeString()
    func getPlaceString()
    
    func setStartTime(time:Date)
    func setEndTime(time:Date)
    
    
    
}
class NewClassPresenter:NewClassPresenterProtocol{
    weak var view:NewClassViewProtocol?
    var newClass:NewClassModel!
    var storage:ClassesStorageServiceProtocol!
    
    required init(view:NewClassViewProtocol, model:NewClassModel, storage:ClassesStorageServiceProtocol) {
        self.view = view
        self.newClass = model
        self.storage = storage
    }
    
    
    func saveClass(){
        
        if !newClass.validateForSave(){
            view?.showErrorSave()
            return
        }
        
        let realmClass = newClass.toRealmModel()
        storage.writeNewClass(newClass: realmClass)
        view?.succsessfullSave()
        
    }
    
    func setBackgroundColor(hex:String){
        newClass.backgroundColor = hex
    }
    
    func getReminderString(){
        let string = newClass.currentReminder.getString()
        
        view?.setReminderString(reminderString: string)
    }
    
    func getTitleString(){
        var string = newClass.title ?? ""
        string = string.isEmpty == true ? "Не выбрано" : string
        view?.setTitleString(title: string)
    }
    
    func getTeacherString(){
        var string = newClass.teacher ?? ""
        string = string.isEmpty == true ? "Не выбрано" : string
        view?.setTeacherString(teacherString: string)
    }
    
    func getTypeString(){
        var string = newClass.type ?? ""
        string = string.isEmpty == true ? "Не выбрано" : string
        view?.setTypeString(typeString: string)
    }
    
    func getPlaceString(){
        var string = newClass.place ?? ""
        string = string.isEmpty == true ? "Не выбрано" : string
        view?.setPlaceString(placeString: string)
    }
    
    func setStartTime(time:Date){
        newClass.startTime = time
    }
    func setEndTime(time:Date){
        newClass.endTime = time
    }
}
