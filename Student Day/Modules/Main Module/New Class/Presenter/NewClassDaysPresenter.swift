//
//  NewClassDaysPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation

protocol NewClassDaysViewProtocol:AnyObject{
    
}

protocol NewClassDaysPresenterProtocol:AnyObject{
    init(view:NewClassDaysViewProtocol, model:NewClassModel)
    func getCountDays()->Int
    func getDayString(index:Int)->String
}
class NewClassDaysPresenter:NewClassDaysPresenterProtocol{
    weak var view:NewClassDaysViewProtocol?
    var newClass:NewClassModel!
        
    required init(view:NewClassDaysViewProtocol, model:NewClassModel) {
        self.view = view
        self.newClass = model
    }
    
    func getCountDays()->Int{
        return newClass.days.count
    }
    func getDayString(index:Int)->String{
        return newClass.days[index].title
    }
}
