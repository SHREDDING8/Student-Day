//
//  NewClassBuilder.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation
import UIKit

protocol NewClassBuilderProtocol{
    static func createReminderViewController()->UIViewController
    
}

class NewClassBuilder:NewClassBuilderProtocol{
    static func createReminderViewController()->UIViewController{
        let view = NewClassReminderTableViewController(style: .insetGrouped)
        let presenter = NewClassReminderPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
