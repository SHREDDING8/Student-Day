//
//  NewClassBuilder.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation
import UIKit

protocol NewClassBuilderProtocol{
    static func createNewClassViewController()->UIViewController
    static func createReminderViewController()->UIViewController
    static func createDaysViewController()->UIViewController
    
}

class NewClassBuilder:NewClassBuilderProtocol{
    static var newClassModel:NewClassModel!
    static func createNewClassViewController()->UIViewController{
        let view = NewClassController(style: .insetGrouped)
        view.hidesBottomBarWhenPushed = true
        newClassModel = NewClassModel()
        let presenter = NewClassPresenter(view: view, model: newClassModel)
        view.presenter = presenter
        return view
    }
    
    static func createReminderViewController()->UIViewController{
        let view = NewClassReminderTableViewController(style: .insetGrouped)
        let presenter = NewClassReminderPresenter(view: view, model: newClassModel)
        view.presenter = presenter
        return view
    }
    static func createDaysViewController()->UIViewController{
        let view = NewClassDaysTableViewController(style: .insetGrouped)
        let presenter = NewClassDaysPresenter(view: view, model: newClassModel)
        view.presenter = presenter
        return view
    }
}
