//
//  LoginViewController.swift
//  Student Day
//
//  Created by SHREDDING on 05.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter:LoginViewPresenterProtocol!
    
    // MARK: - Variables
    var isHidePassword = true
    var doAferClickSignIn:(()->Void)?
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signInButton: UILabel!
    
    
    let eyeGlobalView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return view
    }()
    
    let eyeImageView:UIImageView = {
        let view = UIImageView(frame: CGRect(x: -20, y: -7, width: 15, height: 15))
        view.image =  UIImage(named: "passwordEye")
        view.contentMode = .scaleAspectFill
        return view
        
    }()
    
    let lineimageView:UIImageView = {
        let view = UIImageView(frame: CGRect(x: -21, y: -9, width: 18, height: 18))
        view.image =  UIImage(named: "passwordLine")
        return view
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
    }
    
    // MARK: - Configuration
    
    fileprivate func configureViews(){
        let cornerRadius = 15.0
        
        eyeGlobalView.addSubview(eyeImageView)
        eyeGlobalView.addSubview(lineimageView)
        
        passwordTextField.rightView = eyeGlobalView
        passwordTextField.rightViewMode = .always
        
        setCornerRadius(views: [emailTextField,passwordTextField,logInButton], cornerRadius: cornerRadius)
        setPlaceholder(textFields: [emailTextField,passwordTextField], placeholders: ["Email","Password"])
        
        let gestureEye = UITapGestureRecognizer(target: self, action: #selector(showHidePassword))
        passwordTextField.rightView!.addGestureRecognizer(gestureEye)
        
        signInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSignIn)))
        
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
    
    // MARK: - Actions
    @objc func showHidePassword(){
        self.lineimageView.isHidden =  !self.lineimageView.isHidden
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        isHidePassword = !isHidePassword
    }
    
    @IBAction func logIn(_ sender: Any) {
        textFieldResign(textFields: [emailTextField,passwordTextField])
        presenter.loginTapped(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
        
        user.setEmail(email: emailTextField.text ?? "")
        user.logIn(password: passwordTextField.text ?? "") { result, error in
            if error != nil{
                self.errorAlert(title: "Error", message: "Wrong Email or password")
            }else{
//                (self.parent as! SignInViewController).goToMainPage()
            }

        }
    }
    
    // MARK: - Alerts
    
    fileprivate func errorAlert(title:String,message:String){
        let alert = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionOk)
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Navigation
    
    @objc func goToSignIn(){
        doAferClickSignIn?()
    }
    
}

// MARK: - textField Delegate
extension LoginViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier == "email"{
            passwordTextField.becomeFirstResponder()
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


// MARK: - presenter Extension
extension LoginViewController:LoginViewControllerProtocol{
    
}
