//
//  CellForScheduleModel.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation
import UIKit


var allClassesWithDays:[Int:[CellForScheduleModel]] = [
    0:[],
    1:[],
    2:[],
    3:[],
    4:[],
    5:[],
    6:[]
]

var allClassesWithoutDays:[CellForScheduleModel] = []{
    didSet{
        allClassesWithoutDays = allClassesWithoutDays.sorted(by: { $0.timeStart < $1.timeStart })
    }
}

// MARK: - enum backroundColorCell
/**
 This enum have all possible background colors for one cell
 
 */
enum BackroundColorCell:String{
    case noColor = "settingsCellColor"
    
    case lightBlue = "cell lightBlue"
    case blue = "cell Blue"
    case darkBlue = "cell darkBlue"
    
    case lightBrown = "cell lightBrown"
    case brown = "cell Brown"
    case darkBrown = "cell darkBrown"
    
    case lightGreen = "cell lightGreen"
    case green = "cell Green"
    case darkGreen = "cell darkGreen"
    
    case lightGrey = "cell lightGrey"
    case grey = "cell Grey"
    case darkGrey = "cell darkGrey"
    
    case lightMint = "cell lightMint"
    case mint = "cell Mint"
    case darkMint = "cell darkMint"
    
    case lightOrange = "cell lightOrange"
    case orange = "cell Orange"
    case darkOrange = "cell darkOrange"
    
    case lightPurple = "cell lightPurple"
    case purple = "cell Purple"
    case darkPurple = "cell darkPurple"
    
    case lightRed = "cell lightRed"
    case red = "cell red"
    case darkRed = "cell darkRed"
    
    case lightSky = "cell lightSky"
    case sky = "cell Sky"
    case darksky = "cell darkSky"
    
    case lightYellow = "cell lightYellow"
    case darkYellow = "cell darkYellow"
    case yellow = "cell yellow"
    
    public static let backroundColorCellArray = [
        "settingsCellColor",
        
        "cell lightBlue",
        "cell Blue",
        "cell darkBlue",
        
        "cell lightBrown",
        "cell Brown",
        "cell darkBrown",
        
        "cell lightGreen",
        "cell Green",
        "cell darkGreen",
        
        "cell lightGrey",
        "cell Grey",
        "cell darkGrey",
        
        "cell lightMint",
        "cell Mint",
        "cell darkMint",
        
        "cell lightOrange",
        "cell Orange",
        "cell darkOrange",
        
        "cell lightPurple",
        "cell Purple",
        "cell darkPurple",
        
        "cell lightRed",
        "cell red",
        "cell darkRed",
        
        "cell lightSky",
        "cell Sky",
        "cell darkSky",
        
        "cell lightYellow",
        "cell darkYellow",
        "cell yellow",
        
    ]
    
}


// MARK: - CellForScheduleModelProtocol
protocol CellForScheduleModelProtocol{
    var nameOfCourse:String{ get set}
    var nameOfProf:String{get set}
    var timeStart:Date{get set}
    var timeEnd:Date{get set}
    var place:String{get set}
    var typeOfClass:String{get set}
    
    var backgroundColor:BackroundColorCell{get set}
    var textColor:UIColor{get set}
    
    var userNotification:String{get set}
    
}

// MARK: - CellForScheduleModel
public class CellForScheduleModel:CellForScheduleModelProtocol{
    // properties
    
    var uniqDocumentId:String?
    var nameOfCourse: String

    var nameOfProf: String

    var timeStart: Date
    var timeEnd:Date

    var place: String

    var typeOfClass: String

    var backgroundColor: BackroundColorCell

    var textColor: UIColor = .white
    
    
    var days:[Int:Bool] = [
        0:false,
        1:false,
        2:false,
        3:false,
        4:false,
        5:false,
        6:false
    ]

    var userNotification: String
    
    var notifications:[Notifications] = []

    init(course:String, prof:String, timeStart:Date,timeEnd:Date, place:String,typeOfClass:String,backgroundColor:BackroundColorCell,userNotification:String,days:[Int:Bool]) {
        self.nameOfCourse = course
        self.nameOfProf = prof
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.place = place
        self.typeOfClass = typeOfClass
        self.backgroundColor = backgroundColor
        self.userNotification = userNotification
        self.days = days
        
        if backgroundColor == .noColor{
            textColor = UIColor(named: "gray")!
        }else{
            textColor = .white
        }
    }
    
    init(documentId:String, course:String, prof:String, timeStart:Date,timeEnd:Date, place:String,typeOfClass:String,backgroundColor:BackroundColorCell,userNotification:String,days:[Int:Bool]) {
        self.uniqDocumentId = documentId
        self.nameOfCourse = course
        self.nameOfProf = prof
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.place = place
        self.typeOfClass = typeOfClass
        self.backgroundColor = backgroundColor
        self.userNotification = userNotification
        self.days = days
        
        if backgroundColor == .noColor{
            textColor = UIColor(named: "gray")!
        }else{
            textColor = .white
        }
    }
    
    public func setNotification(){
        
        for (day,value) in self.days{
            if !value{ continue }
            let notification:Notifications = Notifications(identifer: self.uniqDocumentId! + self.nameOfCourse + String(day))
            notifications.append(notification)
            notification.setNotificationScheduleClass(cell: self, day: day)
        }
    }
    
    
    
    deinit {
        for notification in notifications{
            notification.removeNotifications()
        }
    }
}
