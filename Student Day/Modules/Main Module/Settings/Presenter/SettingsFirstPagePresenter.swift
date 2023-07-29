//
//  SettingsFirstPagePresenter.swift
//  Student Day
//
//  Created by SHREDDING on 28.07.2023.
//

import Foundation
import UIKit

protocol SettingsFirstPagePresenterProtocol:AnyObject{
    init(view:SettingsFirstPageControllerProtocol)
}

protocol SettingsFirstPageControllerProtocol:AnyObject{
    
}

class SettingsFirstPagePresenter:SettingsFirstPagePresenterProtocol{
    let view:SettingsFirstPageControllerProtocol?
    required init(view: SettingsFirstPageControllerProtocol) {
        self.view = view
    }
    
}
