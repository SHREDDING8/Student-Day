//
//  NewClassPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 29.07.2023.
//

import Foundation


protocol NewClassViewProtocol:AnyObject{
    func setReminderString(reminderString:String)
    func showErrorSave()
    func succsessfullSave()
}

protocol NewClassPresenterProtocol:AnyObject{
    init(view:NewClassViewProtocol, model:NewClassModel, storage:ClassesStorageServiceProtocol)
    
    func saveClass()
    
    func setBackgroundColor(hex:String)
    
    func getReminderString()
    
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
        
        newClass.title = "test"
        newClass.teacher = "test"
        newClass.type = "test"
        newClass.place = "test"
        
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
        let string = newClass.currentReminder?.getString() ?? NewClassModel.ReminderEnum.none.getString()
        
        view?.setReminderString(reminderString: string)
    }
    
    func setStartTime(time:Date){
        newClass.startTime = time
    }
    func setEndTime(time:Date){
        newClass.endTime = time
    }
}
