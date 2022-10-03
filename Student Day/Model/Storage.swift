//
//  Storage.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation
import UIKit
import CoreData

protocol StorageProtocol{
    var scheduleStorageKey:String { get }
    func getAllClassesFromStorage()->[CellForScheduleModel]?
    func saveAllCleseesToStorage(_: [CellForScheduleModel])
    
}

enum CellKey:String{
    case nameOfProf
    case nameOfCourse
    case timeStart
    case timeEnd
    case place
    case type
    case backgroundColor
    case userNotification
}


class Storage:StorageProtocol{
    var scheduleStorageKey: String = "AllClasses"
    let userdefaluts = UserDefaults.standard
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
//    let dateFormatter = DateFormatter()
    
    func getAllClassesFromStorage() -> [CellForScheduleModel]? {
        
        // Constants
        
        var cells:[CellForScheduleModel] = []
        
        let gettedCellsFromCoreData:[CellsForSchedule]
        
//        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
    
        let fetchRequest:NSFetchRequest<CellsForSchedule> = CellsForSchedule.fetchRequest()
        
        // getting cells from storage
        
        do {
             gettedCellsFromCoreData = try context.fetch(fetchRequest)
        } catch  _ as NSError {
            gettedCellsFromCoreData = []
        }
        
        for gettedClass in gettedCellsFromCoreData{
            
            guard let nameOfProf = gettedClass.nameOfProf,
                let nameOfCourse = gettedClass.nameOfCourse,
                let timeStart = gettedClass.timeStart,
                let timeEnd = gettedClass.timeEnd,
                let place = gettedClass.place,
                let type = TypeClass(rawValue: gettedClass.typeOfClass!),
                let backgroundColor = backroundColorCell(rawValue: gettedClass.backgroundColor!)
                else{
                    continue
            }
            
            let cellToArray = CellForScheduleModel(course:nameOfCourse , prof: nameOfProf, timeStart:timeStart , timeEnd:timeEnd , place:place , typeOfClass: type, backgroundColor:backgroundColor , userNotofocation:gettedClass.userNotofocation)
            cells.append(cellToArray)
        }
        
        return cells
    }
    
    func saveAllCleseesToStorage(_ cells: [CellForScheduleModel]) {
        
        //getting entity
        
        guard let classesEntity = NSEntityDescription.entity(forEntityName: "CellsForSchedule", in: context) else{return}
        
        cells.forEach { cell in
            let cellOblect = CellsForSchedule(entity: classesEntity, insertInto: context)
            
            cellOblect.nameOfCourse = cell.nameOfCourse
            cellOblect.nameOfProf = cell.nameOfProf
            cellOblect.timeStart = cell.timeStart
            cellOblect.timeEnd = cell.timeEnd
            cellOblect.typeOfClass = cell.typeOfClass.rawValue
            cellOblect.backgroundColor = cell.backgroundColor.rawValue
            cellOblect.place = cell.place
            cellOblect.userNotofocation = cell.userNotofocation
            
            do{
                try context.save()
            }catch {
                return
            }
        }
        
    }
    func removeClassFromStorage(indexPath:IndexPath){
        let fetchRequest = CellsForSchedule.fetchRequest()
        
        let sort = NSSortDescriptor(key: "timeStart", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        if let cells = try? context.fetch(fetchRequest){
            context.delete(cells[indexPath.row])
            do{
                try context.save()
            }catch {
                return
            }
        }
        
    }
    
    
}
