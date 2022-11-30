//
//  Storage.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation
import UIKit
import CoreData

// MARK: - StorageProtocol and enums
private protocol StorageProtocol{
    func getAllClassesFromStorage()->[CellForScheduleModel]?
    func saveClassesToStorage(_: [CellForScheduleModel])
    
}

/**
 Enum with possible key for Class/Course
 

 **parameters:**
 - nameOfProf
 - nameOfCourse
 - timeStart
 - timeEnd
 - place
 - type
 - backgroundColor
 - userNotification
 */
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

enum SubjectTeacherPlaceClassType {
    case subject
    case teacher
    case place
    case classType
}


// MARK: - class Storage
class Storage:StorageProtocol{
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - schedule Entities
    /**
     get all Classes/Courses from storage
     
    
     **return**
     - [CellForScheduleModel]?
     */
    public func getAllClassesFromStorage() -> [CellForScheduleModel]? {
        
        // resulting array
        var cells:[CellForScheduleModel] = []
        
        // array from storage
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
            
            // set variables from storage
            guard let nameOfProf = gettedClass.nameOfProf,
                let nameOfCourse = gettedClass.nameOfCourse,
                let timeStart = gettedClass.timeStart,
                let timeEnd = gettedClass.timeEnd,
                let place = gettedClass.place,
                let type = gettedClass.typeOfClass,
                let backgroundColor = BackroundColorCell(rawValue: gettedClass.backgroundColor!),
                let userNotification = gettedClass.userNotification
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
            
            // create class of Class/Course
            let cellToArray = CellForScheduleModel(course:nameOfCourse , prof: nameOfProf, timeStart:timeStart , timeEnd:timeEnd , place:place , typeOfClass: type, backgroundColor:backgroundColor , userNotification:userNotification,days: daysDict)
            cells.append(cellToArray)
        }
        
        return cells
    }
    /**
     this function save array of Classes/Courses to storage
     
     
     **parameters:**
     - cells: array with Classes/Courses
     */
    public func saveClassesToStorage(_ cells: [CellForScheduleModel]) {
        
        // getting entity
        guard let classesEntity = NSEntityDescription.entity(forEntityName: "CellsForSchedule", in: context) else{return}
        
        // set variables
        cells.forEach { cell in
            let cellOblect = CellsForSchedule(entity: classesEntity, insertInto: context)
            
            cellOblect.nameOfCourse = cell.nameOfCourse
            cellOblect.nameOfProf = cell.nameOfProf
            cellOblect.timeStart = cell.timeStart
            cellOblect.timeEnd = cell.timeEnd
            cellOblect.typeOfClass = cell.typeOfClass
            cellOblect.backgroundColor = cell.backgroundColor.rawValue
            cellOblect.place = cell.place
            cellOblect.userNotification = cell.userNotification
            
            cellOblect.monday = cell.days[0]!
            cellOblect.tuesday = cell.days[1]!
            cellOblect.wednesday = cell.days[2]!
            cellOblect.thursday = cell.days[3]!
            cellOblect.friday = cell.days[4]!
            cellOblect.saturday = cell.days[5]!
            cellOblect.sunday = cell.days[6]!
            
            // save model to storage
            do{
                try context.save()
            }catch {
                return
            }
        }
        
    }
    
    /**
     this function removes Class/Course from storage
     
     
     **parameters:**
     - indexPath: IndexPath for determine what Class/Course should be removed
     */
    public func removeClassFromStorage(indexPath:IndexPath){
        let fetchRequest = CellsForSchedule.fetchRequest()
        
        // sort all element in Entity by time start
        let sort = NSSortDescriptor(key: "timeStart", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        // remove class
        if let cells = try? context.fetch(fetchRequest){
            context.delete(cells[indexPath.row])
            do{
                try context.save()
            }catch {
                return
            }
        }
    }
    
    
    // MARK: - SubjectTeacherPlace entities
    /**
     _this functions gets all names of Classes/Courses or Teachers or Places_
     
     
     **parameters:**
     - getting: item of enum SubjectTeacherPlace that means what kind of array shold be
     
     **return:**
     - [String]: array with names of Classes/Courses or Teachers or Places
     */
    public func getSubjectTeacherPlaceClassTypeArray(getting: SubjectTeacherPlaceClassType)->[String]{
        
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
            
        case .classType:
            let fetchRequest = ClassType.fetchRequest()
            var fromStorage:[ClassType] = []
            
            do {
                fromStorage = try context.fetch(fetchRequest)
            } catch  _ as NSError {
                fromStorage = []
            }
            for objectFrom in fromStorage{
                
                returned.append(objectFrom.type ?? "")
            }
        }
        
        returned = returned.sorted()
        return returned
    }
    
    
    /**
     this Function saves array with name of Class/Course or teachers or Places to storage
     
     
     **parameters:**
     - saving:SubjectTeacherPlace - enum (which kind of entity)
     - array: [String] - array with variables
     */
    public func saveSubjectTeacherPlace(saving:SubjectTeacherPlaceClassType,array: [String]){
        
        
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
        case .classType:
            guard let entity = NSEntityDescription.entity(forEntityName: "ClassType", in: context)else{return}
            
            for i in array{
                let objectSave = ClassType(entity: entity, insertInto: context)
                
                objectSave.type = i
                
                do{
                    try context.save()
                }catch {
                    return
                }
            }
        }
        
    }
    
    
    /**
     this function removes from storage Name of Class/Course or Teacher or Place
     
     
     **parameters:**
     - Object:String - variable to remove
     - type:SubjectTeacherPlace - enum (which kind of entity)
     */
    public func removeSubjectTeacherPlace(Object:String, type:SubjectTeacherPlaceClassType){
        
        
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
        case .classType:
            let fetchRequest = ClassType.fetchRequest()
            
            if let cells = try? context.fetch(fetchRequest){
                
                for i in cells{
                    if i.type == Object{
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
