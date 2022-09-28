//
//  Storage.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation

protocol StorageProtocol{
    var scheduleStorageKey:String { get }
    func getAllClassesFromStorage()->[CellForScheduleModel]?
    func saveAllCleseesToStorage(_: [CellForScheduleModel])
    
}

enum CellKey:String{
    case nameOfProf
    case nameOfCourse
    case time
    case place
    case type
    case backgroundColor
    case userNotification
}


class Storage:StorageProtocol{
    var scheduleStorageKey: String = "AllClasses"
    let userdefaluts = UserDefaults.standard
    
    let dateFormatter = DateFormatter()
    
    func getAllClassesFromStorage() -> [CellForScheduleModel]? {
        
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        var cells:[CellForScheduleModel] = []
        let arrayFromStorage = userdefaluts.array(forKey: scheduleStorageKey) as? [[String:String]] ?? []
        for cellFromStorage in arrayFromStorage {
            guard let nameOfProf = cellFromStorage[CellKey.nameOfProf.rawValue],
                let nameOfCourse = cellFromStorage[CellKey.nameOfCourse.rawValue],
                  let time = dateFormatter.date(from: cellFromStorage[CellKey.time.rawValue]!),
                let place = cellFromStorage[CellKey.place.rawValue],
                let type = cellFromStorage[CellKey.type.rawValue],
                let backgroundColor = cellFromStorage[CellKey.backgroundColor.rawValue],
                let userNotification = cellFromStorage[CellKey.userNotification.rawValue] else{
                    continue
            }
            
            let cellToArray = CellForScheduleModel(course: nameOfCourse, prof: nameOfProf, time: time, place: place, typeOfClass: TypeClass(rawValue: type)!, backgroundColor: backroundColorCell(rawValue: backgroundColor)!, userNotofocation: Bool(userNotification)!)
            cells.append(cellToArray)
        }
        
        
        return cells
    }
    
    func saveAllCleseesToStorage(_ cells: [CellForScheduleModel]) {
        var arrayForStorage:[[String:String]] = []
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        cells.forEach { cell in
            var dictForCell:[String:String] = [:]
            dictForCell[CellKey.nameOfProf.rawValue] = cell.nameOfProf
            dictForCell[CellKey.nameOfCourse.rawValue] = cell.nameOfCourse
            dictForCell[CellKey.time.rawValue] = dateFormatter.string(from: cell.time)
            dictForCell[CellKey.type.rawValue] = cell.typeOfClass.rawValue
            dictForCell[CellKey.backgroundColor.rawValue] = cell.backgroundColor.rawValue
            dictForCell[CellKey.place.rawValue] = cell.place
            dictForCell[CellKey.userNotification.rawValue] = String(cell.userNotofocation)
            arrayForStorage.append(dictForCell)
        }
        userdefaluts.set(arrayForStorage, forKey: scheduleStorageKey)
    }
    
    
}
