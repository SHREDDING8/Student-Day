//
//  NewClassPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 29.07.2023.
//

import Foundation


protocol NewClassViewProtocol:AnyObject{
}

protocol NewClassPresenterProtocol:AnyObject{
    init(view:NewClassViewProtocol)

}
class NewClassPresenter:NewClassPresenterProtocol{
    weak var view:NewClassViewProtocol?
    
    required init(view:NewClassViewProtocol) {
        self.view = view
    }
    
}
