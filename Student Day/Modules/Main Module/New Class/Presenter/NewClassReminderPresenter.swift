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
    init(view:NewClassReminderViewProtocol)
    func getReminderCount()->Int
    func getReminderString(index:Int)->String
}
class NewClassReminderPresenter:NewClassReminderPresenterProtocol{
    weak var view:NewClassReminderViewProtocol?
    
    private enum ReminderEnum{
        case none
        case minute5
        case minute15
        case minute30
        case hour1
        case hour2
        case day1
        case day2
        case week1
        
        init(index:Int){
            switch index{
            case 0:
                self = .none
            case 1:
                self = .minute5
            case 2:
                self = .minute15
            case 3:
                self = .minute30
            case 4:
                self = .hour1
            case 5:
                self = .hour2
            case 6:
                self = .day1
            case 7:
                self = .day2
            case 8:
                self = .week1
            default:
                self = .none
            }
        }
        
        func getString()->String{
            switch self {
            case .none:
                return "Не напоминать"
            case .minute5:
                return "Напомнить за 5 минут"
            case .minute15:
                return "Напомнить за 15 минут"
            case .minute30:
                return "Напомнить за 30 минут"
            case .hour1:
                return "Напомнить за 1 час"
            case .hour2:
                return "Напомнить за 2 часа"
            case .day1:
                return "Напомнить за 1 день"
            case .day2:
                return "Напомнить за 2 дня"
            case .week1:
                return "Напомнить за 1 неделю"
            }
        }
    }
    
    required init(view:NewClassReminderViewProtocol) {
        self.view = view
    }
    
    func getReminderCount()->Int{
        return 9
    }
    func getReminderString(index:Int)->String{
        let reminder = ReminderEnum(index: index)
        return reminder.getString()
    }
}
