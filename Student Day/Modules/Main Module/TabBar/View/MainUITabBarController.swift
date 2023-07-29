//
//  MainUITabBarController.swift
//  Student Day
//
//  Created by SHREDDING on 27.07.2023.
//

import UIKit

class MainUITabBarController: UITabBarController {
    
    private enum TabBarImages{
        static let schedule = UIImage(systemName: "calendar")
        static let toDo = UIImage(systemName: "list.bullet.rectangle")
        static let profile = UIImage(systemName: "person")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var viewControllers:[UIViewController] = []
        
        let scheduleViewController = configureViewController(MainModuleBuilder.createScheduleViewController(), title: "Расписание", image: TabBarImages.schedule!)
        
        let toDoViewController = configureViewController(MainModuleBuilder.createToDoViewController(), title: "To Do", image: TabBarImages.toDo!)
        
        let profileViewController = configureViewController(MainModuleBuilder.createProfileViewController(), title: "Профиль", image: TabBarImages.profile!)
        
        viewControllers.append(scheduleViewController)
        viewControllers.append(toDoViewController)
        viewControllers.append(profileViewController)
        

        
        self.setViewControllers(viewControllers, animated: false)
        
    }
    
    fileprivate func configureViewController(_ viewController:UIViewController, title:String,image:UIImage)->UIViewController{
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
}
