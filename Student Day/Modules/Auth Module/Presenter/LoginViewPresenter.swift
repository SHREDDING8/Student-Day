//
//  LoginViewPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 27.07.2023.
//

import Foundation

protocol LoginViewPresenterProtocol: AnyObject{
    init(view: LoginViewControllerProtocol)
    
    func loginTapped(email:String,password:String)
}

protocol LoginViewControllerProtocol: AnyObject{
    
}

class LoginViewPresenter: LoginViewPresenterProtocol{
    weak var view:LoginViewControllerProtocol?
    
    
    required init(view: LoginViewControllerProtocol) {
        self.view = view
    }
    
    
    func loginTapped(email: String, password: String) {
        user.setEmail(email: email)
        user.logIn(password: password) { result, error in
            
        }
    }
    
        
}
