//
//  NewClassReminderPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation

protocol NewClassReminderViewProtocol:AnyObject{
    
}

protocol NewClassReminderPresenterProtocol:AnyObject{
    init(view:NewClassReminderViewProtocol, model:NewClassModel)
    func getReminderCount()->Int
    func getReminderString(index:Int)->String
}
class NewClassReminderPresenter:NewClassReminderPresenterProtocol{
    weak var view:NewClassReminderViewProtocol?
    var newClass:NewClassModel!
    
    
    required init(view:NewClassReminderViewProtocol, model:NewClassModel) {
        self.view = view
        self.newClass = model
    }
    
    func getReminderCount()->Int{
        return 9
    }
    func getReminderString(index:Int)->String{
        let reminder = NewClassModel.ReminderEnum(index: index)
        return reminder.getString()
    }
}
