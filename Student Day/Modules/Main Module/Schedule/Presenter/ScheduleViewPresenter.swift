//
//  ScheduleViewPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 27.07.2023.
//

import Foundation

protocol ScheduleViewControllerProtocol:AnyObject{
    
}

protocol ScheduleViewPresenterProtocol:AnyObject{
    init(view: ScheduleViewControllerProtocol)
}

class ScheduleViewPresenter:ScheduleViewPresenterProtocol {
    weak var view:ScheduleViewControllerProtocol?
    required init(view: ScheduleViewControllerProtocol) {
        self.view = view
    }
    
}
