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
    static func createTitleViewController()->UIViewController
    static func createTeacherViewController()->UIViewController
    static func createTypeViewController()->UIViewController
    static func createPlaceViewController()->UIViewController
    
}

class NewClassBuilder:NewClassBuilderProtocol{
    static var newClassModel:NewClassModel!
    static func createNewClassViewController()->UIViewController{
        let view = NewClassController(style: .insetGrouped)
        view.hidesBottomBarWhenPushed = true
        newClassModel = NewClassModel()
        let storage = ClassesStorageService()
        let presenter = NewClassPresenter(view: view, model: newClassModel, storage: storage)
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
    
    static func createTitleViewController()->UIViewController{
        let view = NewClassAddComponentViewController()
        let storage = ClassesTitleStorageService()
        let presenter = NewClassAddTitlePresenter(view: view, storage: storage, model:newClassModel)
        view.presenter = presenter
        return view
    }
    
    static func createTeacherViewController()->UIViewController{
        let view = NewClassAddComponentViewController()
        let storage = ClassesTeacherStorageService()
        let presenter = NewClassTeacherPresenter(view: view, storage: storage, model:newClassModel)
        view.presenter = presenter
        return view
    }
    
    static func createTypeViewController()->UIViewController{
        let view = NewClassAddComponentViewController()
        let storage = ClassesTypeStorageService()
        let presenter = NewClassTypePresenter(view: view, storage: storage, model:newClassModel)
        view.presenter = presenter
        return view
    }
    
    static func createPlaceViewController()->UIViewController{
        let view = NewClassAddComponentViewController()
        let storage = ClassesPlaceStorageService()
        let presenter = NewClassPlacePresenter(view: view, storage: storage, model:newClassModel)
        view.presenter = presenter
        return view
    }
}
