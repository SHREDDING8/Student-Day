//
//  SignInViewController.swift
//  Student Day
//
//  Created by SHREDDING on 05.04.2023.
//

import UIKit


class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var continueSignInButton: UIButton!
    
    @IBOutlet weak var logInButton: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
    }
    
    // MARK: - Configuration
    
    
    fileprivate func configureViews(){
        let cornerRadius = 15.0
        setCornerRadius(views: [firstNameTextField,secondNameTextField,emailTextField,continueSignInButton], cornerRadius: cornerRadius)
        setPlaceholder(textFields: [firstNameTextField,secondNameTextField,emailTextField], placeholders: ["First name","Last name","Email"])
        
        
        // set actions
        logInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToLogin)))
        continueSignInButton.addTarget(nil, action: #selector(continueSignIn), for: .touchUpInside)
        
    }
    
    fileprivate func setCornerRadius(views:[UIView],cornerRadius:Double){
        for view in views{
            view.layer.masksToBounds = true
            view.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    fileprivate func setPlaceholder(textFields:[UITextField],placeholders:[String]){
        let placeHolderAttrubites = NSAttributedString(
            string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        for index in 0..<textFields.count{
            textFields[index].attributedPlaceholder = placeHolderAttrubites
            textFields[index].placeholder = placeholders[index]
        }
    }
    
    
    // MARK: - Navigation (goToLogin)
    
    @objc func goToLogin(){
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        loginViewController.doAferClickSignIn = {
            self.removeChild(controller: loginViewController)
        }
        
        addAndShowChild(controller: loginViewController)
    }
    
    @objc func continueSignIn(){
        
        // resign text field

        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        
        // validation
        if textFieldsIsEmpty(textFields: [firstNameTextField,secondNameTextField,emailTextField]){
            errorAlert(title: "Error", message: "Some fields is empty")
            return
        }else if !isValidEmail(email: emailTextField.text ?? ""){
            errorAlert(title: "Error", message: "Email incorrect")
            return
        }
        
        
        user.setUserFirstName(firstName: firstNameTextField.text!)
        user.setLastName(lastName: secondNameTextField.text!)
        user.setEmail(email: emailTextField.text!)
        let passwordViewController = storyboard?.instantiateViewController(withIdentifier: "passwordViewController") as! passwordViewController
        
        passwordViewController.doAfterBack = {
            self.removeChild(controller: passwordViewController)
        }
        
        passwordViewController.doAfterClickLogin = {
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            loginViewController.doAferClickSignIn = {
                self.removeChild(controller: loginViewController)
                
                
            }
            
            self.addAndShowChild(controller: loginViewController)
            self.removeChild(controller: passwordViewController)
            
        }
        
        isUserExistByEmail(email: emailTextField.text ?? "") { [self] isExist in
            if isExist{
                errorAlert(title: "Error", message: "Account with this email exist")
            }else{
                self.addAndShowChild(controller: passwordViewController)
            }
        }
    }
    
    
    // MARK: - Childs
    
    fileprivate func addAndShowChild(controller:UIViewController){
        self.addChild(controller)
        UIView.transition(with: self.view, duration: 0.5,options: .transitionCrossDissolve) {
            self.view.addSubview(controller.view)
        }
    }
    
    fileprivate func removeChild(controller:UIViewController){
        
        UIView.transition(with: self.view, duration: 0.5,options: .transitionCrossDissolve) {
            controller.view.removeFromSuperview()
        }
        controller.removeFromParent()
    }
    
    
    // MARK: - Alerts
    
    fileprivate func errorAlert(title:String,message:String){
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionOk)
        self.present(alert, animated: true)
    }
}

// MARK: - TextField Delegate

extension SignInViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier == "firstName"{
            secondNameTextField.becomeFirstResponder()
        }else if textField.restorationIdentifier == "secondName"{
            emailTextField.becomeFirstResponder()
        }else{
            emailTextField.resignFirstResponder()
        }
        return true
    }
}
