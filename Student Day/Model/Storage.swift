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

enum SubjectTeacherPlace {
    case subject
    case teacher
    case place
}


class Storage:StorageProtocol{
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
//    let dateFormatter = DateFormatter()
    
    func getAllClassesFromStorage() -> [CellForScheduleModel]? {
        
        // Constants
        
        var cells:[CellForScheduleModel] = []
        
        let gettedCellsFromCoreData:[CellsForSchedule]
        
    
        let fetchRequest:NSFetchRequest<CellsForSchedule> = CellsForSchedule.fetchRequest()
        
        // getting cells from storage
        
        do {
             gettedCellsFromCoreData = try context.fetch(fetchRequest)
        } catch  _ as NSError {
            gettedCellsFromCoreData = []
        }
        
        for gettedClass in gettedCellsFromCoreData{
            var daysDict:[Int:Bool] = [
                0:false,
                1:false,
                2:false,
                3:false,
                4:false,
                5:false,
                6:false
            ]
            
            guard let nameOfProf = gettedClass.nameOfProf,
                let nameOfCourse = gettedClass.nameOfCourse,
                let timeStart = gettedClass.timeStart,
                let timeEnd = gettedClass.timeEnd,
                let place = gettedClass.place,
                let type = TypeClass(rawValue: gettedClass.typeOfClass!),
                let backgroundColor = backroundColorCell(rawValue: gettedClass.backgroundColor!),
                let userNotification = gettedClass.userNotofocation
                else{
                    continue
            }
            daysDict[0] = gettedClass.monday
            daysDict[1] = gettedClass.tuesday
            daysDict[2] = gettedClass.wednesday
            daysDict[3] = gettedClass.thursday
            daysDict[4] = gettedClass.friday
            daysDict[5] = gettedClass.saturday
            daysDict[6] = gettedClass.sunday
            
            let cellToArray = CellForScheduleModel(course:nameOfCourse , prof: nameOfProf, timeStart:timeStart , timeEnd:timeEnd , place:place , typeOfClass: type, backgroundColor:backgroundColor , userNotofocation:userNotification,days: daysDict)
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
            
            cellOblect.monday = cell.days[0]!
            cellOblect.tuesday = cell.days[1]!
            cellOblect.wednesday = cell.days[2]!
            cellOblect.thursday = cell.days[3]!
            cellOblect.friday = cell.days[4]!
            cellOblect.saturday = cell.days[5]!
            cellOblect.sunday = cell.days[6]!
            
            do{
                try context.save()
            }catch {
                return
            }
        }
        
    }
    func removeClassFromStorage(indexPath:IndexPath){
        let fetchRequest = CellsForSchedule.fetchRequest()
        
        let sort = NSSortDescriptor(key: "timeStart", ascending: true)
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
    
    
    func getSubjectTeacherPlace(getting: SubjectTeacherPlace)->[String]{
        
        var returned:[String] = []
        
        switch getting{
            
        case .place:
            let fetchRequest = Place.fetchRequest()
            var fromStorage:[Place]
            do {
                fromStorage = try context.fetch(fetchRequest)
            } catch  _ as NSError {
                fromStorage = []
            }
            
            
            for objectFrom in fromStorage{
                
                returned.append(objectFrom.place ?? "")
            }
        case .subject:
            let fetchRequest = Subject.fetchRequest()
            var fromStorage:[Subject] = []
            do {
                fromStorage = try context.fetch(fetchRequest)
            } catch  _ as NSError {
                fromStorage = []
            }
            
            
            for objectFrom in fromStorage{
                
                returned.append(objectFrom.subject ?? "")
            }
        case .teacher:
            let fetchRequest = Teacher.fetchRequest()
            var fromStorage:[Teacher] = []
            
            do {
                fromStorage = try context.fetch(fetchRequest)
            } catch  _ as NSError {
                fromStorage = []
            }
            
            for objectFrom in fromStorage{
                
                returned.append(objectFrom.teacher ?? "")
            }
        }
        
        returned = returned.sorted()
        return returned
    }
    
    func saveSubjectTeacherPlace(saving:SubjectTeacherPlace,array: [String]){
        
        
    
        switch saving {
        case .subject:
            guard let entity = NSEntityDescription.entity(forEntityName: "Subject", in: context)else{return}
            
            for i in array{
                let objectSave = Subject(entity: entity, insertInto: context)
                
                objectSave.subject = i
                
                do{
                    try context.save()
                }catch {
                    return
                }
            }
        case .teacher:
            guard let entity = NSEntityDescription.entity(forEntityName: "Teacher", in: context)else{return}
            
            
            for i in array{
                let objectSave = Teacher(entity: entity, insertInto: context)
                
                objectSave.teacher = i
                
                do{
                    try context.save()
                }catch {
                    return
                }
            }
        case .place:
            guard let entity = NSEntityDescription.entity(forEntityName: "Place", in: context)else{return}
            
            for i in array{
                let objectSave = Place(entity: entity, insertInto: context)
                
                objectSave.place = i
                
                do{
                    try context.save()
                }catch {
                    return
                }
            }
        }
        
    }
    
    
    func removeSubjectTeacherPlace(Object:String, type:SubjectTeacherPlace){
        
        
        switch type {
        case .subject:
            let fetchRequest = Subject.fetchRequest()
            if let cells = try? context.fetch(fetchRequest){
                
                for i in cells{
                    if i.subject == Object{
                        context.delete(i)
                        do{
                            try context.save()
                        }catch {
                            return
                        }
                    }
                }
                
            }
            
        case .teacher:
            let fetchRequest = Teacher.fetchRequest()
            
            if let cells = try? context.fetch(fetchRequest){
                
                for i in cells{
                    if i.teacher == Object{
                        context.delete(i)
                        do{
                            try context.save()
                        }catch {
                            return
                        }
                    }
                }
                
            }
            
            
        case .place:
            let fetchRequest = Place.fetchRequest()
            
            if let cells = try? context.fetch(fetchRequest){
                
                for i in cells{
                    if i.place == Object{
                        context.delete(i)
                        do{
                            try context.save()
                        }catch {
                            return
                        }
                    }
                }
                
            }
        }
        
    }
    
    
}
