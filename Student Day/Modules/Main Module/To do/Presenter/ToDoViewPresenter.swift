//
//  ToDoViewPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 27.07.2023.
//

import Foundation


protocol ToDoViewControllerProtocol:AnyObject{
    
}

protocol ToDoViewPresenterProtocol:AnyObject{
    init(view:ToDoViewControllerProtocol)
}
class ToDoViewPresenter:ToDoViewPresenterProtocol{
    weak var view:ToDoViewControllerProtocol?
    
    required init(view:ToDoViewControllerProtocol) {
        self.view = view
    }
}
