//
//  Auth.swift
//  Student Day
//
//  Created by SHREDDING on 05.04.2023.
//

import Foundation
import UIKit

import FirebaseAuth
import FirebaseCore

let user = User()

class User{
    
    let authStorage = AuthStorage()
    
    
    private var firstName:String?
    private var lastName:String?
    private var email:String?
    private var uid:String?
    
    
    // MARK: - Set functions
    public func setUserFirstName(firstName:String){
        self.firstName = firstName
    }
    public func setLastName(lastName:String){
        self.lastName = lastName
    }
    public func setEmail(email:String){
        self.email = email
    }
    
    public func setUid(uid:String){
        self.uid = uid
    }
    
    // MARK: - Get functions
    public func getFirstName()->String{
        return self.firstName ?? ""
    }
    public func getLastName()->String{
        return self.lastName ?? ""
    }
    public func getEmail()->String{
        return self.email ?? ""
    }
    public func getUid() ->String{
        return self.uid ?? ""
    }
    
    
    // MARK: - createUserWithEmail
    public func createUserWithEmail(password:String, completion:@escaping ((AuthDataResult?,Error?)->Void)){
        Auth.auth().createUser(withEmail: self.email!, password: password) { result, error in
            if error != nil{
                completion(nil, error)
            }else{
                self.setUid(uid: (result?.user.uid)!)
                self.authStorage.saveNewUser(uid: self.getUid(), email: self.getEmail(), firstName: self.getFirstName(), secondName: self.getLastName())
                completion(result, nil)
            }
        }
    }
    
    public func logIn(password:String, completion:@escaping ((AuthDataResult?,Error?)->Void)) {
//        self.setIsLogin(isLogin: true)
        Auth.auth().signIn(withEmail: self.email!, password: password) { result, error in
            if error != nil{
                completion(nil,error)
            }else{
                self.setUid(uid: (result?.user.uid)!)
                completion(result,nil)
            }
        }
    }
    public func signOut(){
        try? Auth.auth().signOut()
    }
}


