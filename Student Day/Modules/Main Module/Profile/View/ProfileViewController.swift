//
//  ProfileViewController.swift
//  Student Day
//
//  Created by SHREDDING on 06.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter:ProfileViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ProfileViewController:ProfileViewControllerProtocol{
    
}
