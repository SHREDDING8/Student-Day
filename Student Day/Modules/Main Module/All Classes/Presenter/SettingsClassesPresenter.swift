//
//  SettingsClassesPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 28.07.2023.
//

import Foundation


protocol SettingsClassesProtocol:AnyObject{
    
}

protocol SettingsClassesPresenterProtocol:AnyObject{
    init(view:SettingsClassesProtocol)
}
class SettingsClassesPresenter:SettingsClassesPresenterProtocol{
    weak var view:SettingsClassesProtocol?
    
    required init(view:SettingsClassesProtocol) {
        self.view = view
    }
}
