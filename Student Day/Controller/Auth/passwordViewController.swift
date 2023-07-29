//
//  passwordViewController.swift
//  Student Day
//
//  Created by SHREDDING on 05.04.2023.
//

import UIKit

class passwordViewController: UIViewController {
    
    // MARK: - Variables
    
    var doAfterClickLogin: (()->Void)?
    var doAfterBack: (()->Void)?
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var firstPassword: UITextField!
    
    @IBOutlet weak var secondPassword: UITextField!
    
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var logInButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    // MARK: - Configuration
    
    fileprivate func configureViews(){
        let cornerRadius = 15.0
        setCornerRadius(views: [firstPassword,secondPassword,signInButton], cornerRadius: cornerRadius)
        setPlaceholder(textFields: [firstPassword,secondPassword], placeholders: ["Password","Repeat Password"])
        
        
        logInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToLogin)))
        
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
    
    
    // MARK: - SignIn
    
    @IBAction func signIn(_ sender: Any) {
        textFieldResign(textFields: [firstPassword,secondPassword])
        
        if !isValidPassword(passwordFirst: firstPassword.text ?? "", passwordSecond: secondPassword.text ?? ""){
            errorAlert(title: "Error" , message: "invalid password")
            return
        }
        
        
        user.createUserWithEmail(password: firstPassword.text!) { result, error in
            if (error != nil){
            }else{
                user.logIn(password: self.firstPassword.text!) { result, error in
                    if error != nil{
                    }else{
//                        (self.parent as! SignInViewController).goToMainPage()
                    }
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    @objc func goToLogin(){
        UIView.transition(with: self.view, duration: 0.5,options: .transitionCrossDissolve) {
            self.doAfterClickLogin?()
        }
    }

    @IBAction func backTransition(_ sender: Any) {
        UIView.transition(with: self.view, duration: 0.5,options: .transitionCrossDissolve) {
            self.doAfterBack?()
        }
    }
    
    
    // MARK: - Alerts
    
    fileprivate func errorAlert(title:String,message:String){
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionOk)
        self.present(alert, animated: true)
    }

}

extension passwordViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier == "password"{
            secondPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    fileprivate func textFieldResign(textFields:[UITextField]){
        for textField in textFields{
            textField.resignFirstResponder()
        }
    }
}
