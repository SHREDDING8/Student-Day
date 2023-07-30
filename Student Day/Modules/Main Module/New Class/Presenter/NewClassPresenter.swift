//
//  NewClassPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 29.07.2023.
//

import Foundation


protocol NewClassViewProtocol:AnyObject{
    func setReminderString(reminderString:String)
}

protocol NewClassPresenterProtocol:AnyObject{
    init(view:NewClassViewProtocol, model:NewClassModel)
    func setBackgroundColor(hex:String)
    func getReminderString()

}
class NewClassPresenter:NewClassPresenterProtocol{
    weak var view:NewClassViewProtocol?
    var newClass:NewClassModel!
    
    required init(view:NewClassViewProtocol, model:NewClassModel) {
        self.view = view
        self.newClass = model
    }
    
    func setBackgroundColor(hex:String){
        newClass.backgroundColor = hex
    }
    
    func getReminderString(){
        let string = newClass.currentReminder?.getString() ?? NewClassModel.ReminderEnum.none.getString()
        
        view?.setReminderString(reminderString: string)
    }
    
}
