//
//  NewClassReminderPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation

protocol NewClassReminderViewProtocol:AnyObject{
    func setCheckmark(index:Int)
    func removeCheckmark(index:Int)
    func dismiss()
}

protocol NewClassReminderPresenterProtocol:AnyObject{
    init(view:NewClassReminderViewProtocol, model:NewClassModel)
    func getReminderCount()->Int
    func getReminderString(index:Int)->String
    func isCurrentReminder(index:Int)->Bool
    func setReminder(index:Int)
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
    
    func isCurrentReminder(index:Int)->Bool{
        let guessReminder = NewClassModel.ReminderEnum(index: index)
        
        return newClass.currentReminder == guessReminder
    }
    func setReminder(index:Int){
        let lastReminderIndex = newClass.currentReminder.getIndex()
        view?.removeCheckmark(index: lastReminderIndex)
        
        
        newClass.currentReminder = .init(index: index)
        view?.setCheckmark(index:index)
        view?.dismiss()
        
    }
}
