//
//  Storage.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import Foundation
import UIKit
import CoreData

import FirebaseCore
//import FirebaseFirestore

// MARK: - StorageProtocol and enums
private protocol StorageProtocol{
    func getAllClassesFromStorage(completion:@escaping (([CellForScheduleModel])->Void) )
    func saveClassesToStorage(cell: CellForScheduleModel)->String
    
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

// MARK: - class Storage
class Storage:StorageProtocol{
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    static let database = Firestore.firestore()
//    let databaseScheduleRef = database.collection("Schedule")
    
    
    // MARK: - getAllClassesFromStorage
    /**
     get all Classes/Courses from storage
     
     
     **return**
     - [CellForScheduleModel]?
     */
    public func getAllClassesFromStorage(completion:@escaping (([CellForScheduleModel])->Void) ){
//        let userScheduleDocument = databaseScheduleRef.document(user.getUid())
//        let userClassesCollectionRef = userScheduleDocument.collection("Classes")
//        
//        // resulting array
//        var cells:[CellForScheduleModel] = []
//        
//        
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        userClassesCollectionRef.getDocuments { querySnapshot, error in
//            if error != nil{
//                print("ERROR: getAllClassesFromStorage")
//            }else{
//                print(querySnapshot!.documents.count)
//                for QueryDocumentSnapshot in querySnapshot!.documents{
//                    let data = QueryDocumentSnapshot.data()
//                    
//                    var daysDict:[Int:Bool] = [
//                        0:false,
//                        1:false,
//                        2:false,
//                        3:false,
//                        4:false,
//                        5:false,
//                        6:false
//                    ]
//                    
//                    // set variables from storage
//                    let documentId = QueryDocumentSnapshot.documentID
//                    let nameOfProf = data["nameOfClass"] as! String
//                    let nameOfCourse = data["nameOfTeacher"] as! String
//                    let timeStart = (data["timeStart"] as! Timestamp).dateValue()
//                    let timeEnd = (data["timeFinish"] as! Timestamp).dateValue()
//                    let place = data["place"] as! String
//                    let type = data["typeOfClass"] as! String
//                    let backgroundColor = BackroundColorCell(rawValue: data["backgroundColor"] as! String)
//                    let userNotification = data["userNotification"] as! String
//                    
//                    
//                    let days = data["days"] as! [Bool]
//                    daysDict[0] = days[0]
//                    daysDict[1] = days[1]
//                    daysDict[2] = days[2]
//                    daysDict[3] = days[3]
//                    daysDict[4] = days[4]
//                    daysDict[5] = days[5]
//                    daysDict[6] = days[6]
//                    
//                    
//                    // create class of Class/Course
//                    
//                    let newCell = CellForScheduleModel(documentId:documentId,course: nameOfCourse, prof: nameOfProf, timeStart: timeStart, timeEnd: timeEnd, place: place, typeOfClass: type, backgroundColor: backgroundColor!, userNotification: userNotification, days: daysDict)
//                    
//                    cells.append(newCell)
//                }
//                
//            }
//            dispatchGroup.leave()
//        }
//        dispatchGroup.notify(queue: .main) {
//            completion(cells)
//        }
        
    }
    
    // MARK: - saveClassesToStorage
    /**
     this function save array of Classes/Courses to storage
     
     
     **parameters:**
     - cells: array with Classes/Courses
     */
    public func saveClassesToStorage(cell: CellForScheduleModel)->String{
//        let userScheduleDocument = databaseScheduleRef.document(user.getUid())
//        let userClassesCollectionRef = userScheduleDocument.collection("Classes")
//        
//            let userClassDocument = userClassesCollectionRef.document()
//            userClassDocument.setData([
//                "nameOfClass":cell.nameOfCourse,
//                "nameOfTeacher":cell.nameOfProf,
//                "timeStart":cell.timeStart,
//                "timeFinish":cell.timeEnd,
//                "typeOfClass":cell.typeOfClass,
//                "backgroundColor":cell.backgroundColor.rawValue,
//                "place":cell.place,
//                "userNotification":cell.userNotification,
//                "days":[cell.days[0]!,cell.days[1]!,cell.days[2]!,cell.days[3]!,cell.days[4]!,cell.days[5]!,cell.days[6]!]
//            ])
//        
//        return userClassDocument.documentID
        return ""
    }
    
    // MARK: - removeClassFromStorage
    /**
     this function removes Class/Course from storage
     
     
     **parameters:**
     - indexPath: IndexPath for determine what Class/Course should be removed
     */
    public func removeClassFromStorage(documentId:String){
//        let userScheduleDocument = databaseScheduleRef.document(user.getUid())
//        let userClassesCollectionRef = userScheduleDocument.collection("Classes")
//        let documentCell = userClassesCollectionRef.document(documentId)
//        documentCell.delete()
    }
    
    
    // MARK: - getClassField
    /**
     _this functions gets all names of Classes/Courses or Teachers or Places_
     
     
     **parameters:**
     - getting: item of enum SubjectTeacherPlace that means what kind of array shold be
     
     **return:**
     - [String]: array with names of Classes/Courses or Teachers or Places
     */
    public func getClassField(get: ClassFieldType,completion: @escaping (([ClassField])->Void)   ){
//        let userScheduleDocument = databaseScheduleRef.document(user.getUid())
//        let ClassNameCollectionRef = userScheduleDocument.collection(get.rawValue)
//        var classFields:[ClassField] = []
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        ClassNameCollectionRef.getDocuments { querySnapshot, error in
//            guard error == nil else{ return }
//            querySnapshot?.documents.forEach({ queryDocumentSnapshot in
//                let data = queryDocumentSnapshot.data()
//                let text = data[get.rawValue] as! String
//                classFields.append(ClassField(classFieldType: get, classFieldDocumentId: queryDocumentSnapshot.documentID, ClassFieldText: text))
//            })
//            dispatchGroup.leave()
//        }
//        dispatchGroup.notify(queue: .main) {
//            completion(classFields)
//        }
    }
    
    // MARK: - saveClassField
    /**
     this Function saves array with name of Class/Course or teachers or Places to storage
     
     
     **parameters:**
     - saving:SubjectTeacherPlace - enum (which kind of entity)
     - array: [String] - array with variables
     */
    public func saveClassField(classField:ClassField){
//        let userScheduleDocument = databaseScheduleRef.document(user.getUid())
//        let ClassNameCollectionRef = userScheduleDocument.collection(classField.classFieldType.rawValue)
//        let saveClassNameDocument = ClassNameCollectionRef.document()
//        saveClassNameDocument.setData([classField.classFieldType.rawValue: classField.ClassFieldText])
    }
    /**
     this function removes from storage Name of Class/Course or Teacher or Place
     
     
     **parameters:**
     - Object:String - variable to remove
     - type:SubjectTeacherPlace - enum (which kind of entity)
     */
    
    // MARK: - removeClassField
    public func removeClassField(classField:ClassField){
//        let userScheduleDocument = databaseScheduleRef.document(user.getUid())
//        let ClassNameCollectionRef = userScheduleDocument.collection(classField.classFieldType.rawValue)
//        let removeClassNameDocument = ClassNameCollectionRef.document(classField.classFieldDocumentId ?? "")
//        removeClassNameDocument.delete()
    }
}
