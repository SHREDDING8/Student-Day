//
//  NewToDoPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 29.07.2023.
//

import Foundation

protocol NewToDoViewProtocol:AnyObject{
    
}

protocol NewToDoPresenterProtocol:AnyObject{
    init(view:NewToDoViewProtocol)
}
class NewToDoPresenter:NewToDoPresenterProtocol{
    weak var view:NewToDoViewProtocol?
    
    required init(view:NewToDoViewProtocol) {
        self.view = view
    }
}
