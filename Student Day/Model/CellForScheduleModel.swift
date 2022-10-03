//
//  CellForScheduleModel.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation
import UIKit

enum TypeClass:String{
    case lecture = "Лекция"
    case tutorial = "Туториал"
    case lab = "Лабораторная"
    case practice = "Практика"
    case lesson = "Урок"
    case meeting = "Встреча"
    case work = "Работа"
    
}
let typeClassArray = [
    "Лекция",
    "Туториал",
    "Лабораторная",
    "Практика",
    "Урок",
    "Встреча",
    "Работа"
]

enum backroundColorCell:String{
    case noColor = "settingsCellColor"
    case red = "cell red"
    case blue = "cell blue"
    case lightYellow = "cell light yellow"
    case pink = "cell pink"
}
let backroundColorCellArray = [
    "settingsCellColor",
    "cell red",
    "cell blue",
    "cell light yellow",
    "cell pink"
]
protocol CellForScheduleModelProtocol{
    var nameOfCourse:String{ get set}
    var nameOfProf:String{get set}
    var timeStart:Date{get set}
    var timeEnd:Date{get set}
    var place:String{get set}
    var typeOfClass:TypeClass{get set}
    
    var backgroundColor:backroundColorCell{get set}
    var textColor:UIColor{get set}
    
    var userNotofocation:Bool{get set}
    
}

class CellForScheduleModel:CellForScheduleModelProtocol{
    // properties
    var nameOfCourse: String

    var nameOfProf: String

    var timeStart: Date
    var timeEnd:Date

    var place: String

    var typeOfClass: TypeClass

    var backgroundColor: backroundColorCell

    var textColor: UIColor = .white

    internal var userNotofocation: Bool

    // init
    init(course:String, prof:String, timeStart:Date,timeEnd:Date, place:String,typeOfClass:TypeClass,backgroundColor:backroundColorCell,userNotofocation:Bool) {
        self.nameOfCourse = course
        self.nameOfProf = prof
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.place = place
        self.typeOfClass = typeOfClass
        self.backgroundColor = backgroundColor
        self.userNotofocation = userNotofocation
        
        if backgroundColor == .noColor{
            textColor = UIColor(named: "gray")!
        }else{
            textColor = .white
        }
    }
    
    //MARK: - cell Classes

}

