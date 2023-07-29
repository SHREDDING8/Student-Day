//
//  ValidationAuth.swift
//  Student Day
//
//  Created by SHREDDING on 05.04.2023.
//

import Foundation
import UIKit

import FirebaseCore
import FirebaseAuth

// MARK: - textFieldsIsEmpty
public func textFieldsIsEmpty(textFields:[UITextField]) -> Bool{
    
    for textField in textFields{
        if textField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")) == "" || textField.text == nil{ return true }
    }
    return false
}

// MARK: - isValidEmail
public func isValidEmail(email:String) -> Bool{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

// MARK: - isUserExistByEmail
public func isUserExistByEmail(email:String, completion: @escaping ((Bool)->Void) ) {
    Auth.auth().fetchSignInMethods(forEmail: email) { providers, error in
        if error != nil{
            completion(false)
            
        }else if providers != nil{
                completion(true)
            
        }else{
            completion(false)
        }
    }
}

// MARK: - PasswordValid
public func isValidPassword(passwordFirst:String,passwordSecond:String) -> Bool{
    if (passwordFirst.trimmingCharacters(in: CharacterSet(charactersIn: " ")).count) < 8{
        return false
    }
    if passwordFirst != passwordSecond{
        return false
    }
    return true
}

