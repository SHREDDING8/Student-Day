//
//  ProfileViewPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 28.07.2023.
//

import Foundation

protocol ProfileViewPresenterProtocol: AnyObject{
    init(view:ProfileViewControllerProtocol)
}
protocol ProfileViewControllerProtocol: AnyObject{
    
}

class ProfileViewPresenter: ProfileViewPresenterProtocol{
    weak var view:ProfileViewControllerProtocol?
    
    required init(view: ProfileViewControllerProtocol) {
        self.view = view
    }
    
    
}
