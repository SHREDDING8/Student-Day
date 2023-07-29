//
//  AuthBuider.swift
//  Student Day
//
//  Created by SHREDDING on 26.07.2023.
//

import Foundation
import UIKit

protocol AuthBuiderProtocol{
    static func createLoginViewController()->UIViewController
}

class AuthBuider: AuthBuiderProtocol{
    static func createLoginViewController() -> UIViewController {
        
        let view = LoginViewController()
        let presenter = LoginViewPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
    
}
