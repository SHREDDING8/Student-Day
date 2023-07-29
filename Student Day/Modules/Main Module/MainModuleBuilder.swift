//
//  MainModuleBuilder.swift
//  Student Day
//
//  Created by SHREDDING on 27.07.2023.
//

import Foundation
import UIKit

protocol MainModuleBuilderProtocol{
    static func createMainNavigationController()->UITabBarController
    static func createScheduleViewController()->UINavigationController
    
    static func createToDoViewController()->UINavigationController
    static func createNewToDoViewController()->UIViewController
    
    static func createProfileViewController()->UINavigationController
    
    static func createSettingsViewController()->UIViewController
    
    static func createAllClassesViewController()->UIViewController
    static func createNewClassViewController()->UIViewController
    
}

class MainModuleBuilder:MainModuleBuilderProtocol{
    static func createMainNavigationController() -> UITabBarController {
        let tabBar = MainUITabBarController()
        return tabBar
    }
    
    static func createScheduleViewController() -> UINavigationController {
        let view = ScheduleViewController()
        let presenter = ScheduleViewPresenter(view: view)
        view.presenter = presenter
        let navBar = UINavigationController(rootViewController: view)
        return navBar
    }
    
    static func createToDoViewController() -> UINavigationController {
        let view = ToDoViewController()
        let presenter = ToDoViewPresenter(view: view)
        view.presenter = presenter
        let navBar = UINavigationController(rootViewController: view)
        return navBar
    }
    
    static func createNewToDoViewController()->UIViewController{
        let view = NewToDoViewController()
        let presenter = NewToDoPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createProfileViewController() -> UINavigationController {
        let view = ProfileViewController()
        let presenter = ProfileViewPresenter(view: view)
        view.presenter = presenter
        let navBar = UINavigationController(rootViewController: view)
        return navBar
    }
    
    static func createSettingsViewController()->UIViewController{
        let view = SettingsFirstPageController()
        let presenter = SettingsFirstPagePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createAllClassesViewController()->UIViewController{
        let view = SettingsClassesController()
        let presenter = SettingsClassesPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createNewClassViewController()->UIViewController{
        let view = AddingClassController(style: .insetGrouped)
        let presenter = NewClassPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
}
