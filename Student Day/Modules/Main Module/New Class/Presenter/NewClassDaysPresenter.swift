//
//  NewClassDaysPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import Foundation

protocol NewClassDaysViewProtocol:AnyObject{
    func changeAccesoryType(toChange:[IndexPath:Bool])
}

protocol NewClassDaysPresenterProtocol:AnyObject{
    init(view:NewClassDaysViewProtocol, model:NewClassModel)
    func getCountDays()->Int
    func getDayString(index:Int)->String
    func getDayIsSelected(index:Int)->Bool
    
    func dayTapped(indexPath:IndexPath)
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
    func getDayIsSelected(index:Int)->Bool{
        return newClass.days[index].isSelected
    }
    
    func dayTapped(indexPath:IndexPath){
        newClass.days[indexPath.row].isSelected = !newClass.days[indexPath.row].isSelected
        let result = [indexPath: newClass.days[indexPath.row].isSelected]
        view?.changeAccesoryType(toChange:result)
    }
}
