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
    init(view:NewClassViewProtocol, model:NewClassModel)
    func setBackgroundColor(hex:String)

}
class NewClassPresenter:NewClassPresenterProtocol{
    weak var view:NewClassViewProtocol?
    var newClass:NewClassModel!
    
    required init(view:NewClassViewProtocol, model:NewClassModel) {
        self.view = view
        self.newClass = model
    }
    
    func setBackgroundColor(hex:String){
        newClass.backgroundColor = hex
    }
    
}
