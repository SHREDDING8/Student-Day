//
//  Storage.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation

protocol StorageProtocol{
    var scheduleStorageKey:String { get }
    func getAllClassesFromStorage()->[CellForScheduleModel]
    func saveAllCleseesToStorage(_: [CellForScheduleModel])
    
}


class Storage:StorageProtocol{
    var scheduleStorageKey: String = "AllClasses"
    let userdefaluts = UserDefaults.standard
    
    func getAllClassesFromStorage() -> [CellForScheduleModel] {
        let cells = userdefaluts.object(forKey: scheduleStorageKey) as! [CellForScheduleModel]
        return cells
    }
    
    func saveAllCleseesToStorage(_ cells: [CellForScheduleModel]) {
        userdefaluts.set(cells, forKey: scheduleStorageKey)
    }
    
    
}
