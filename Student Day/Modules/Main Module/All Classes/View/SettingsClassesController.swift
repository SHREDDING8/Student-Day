//
//  SettingsClassesController.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import UIKit
import UIColor_Extensions

class SettingsClassesController: UITableViewController {
    
    var presenter:SettingsClassesPresenterProtocol?
    
    var isFirstLoad:Bool = true
    let storage = Storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()
        presenter?.getAllClasses()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.getClassesCount() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let asd = UINib(nibName: "CellForSchedule", bundle: nil)
        tableView.register(asd, forCellReuseIdentifier: "CellForSchedule")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForSchedule", for: indexPath) as! CellForSchedule
        
        cell.nameOfCourse.text = presenter?.classes[indexPath.row].title
        cell.nameOfProf.text = presenter?.classes[indexPath.row].teacher
        cell.place.text = presenter?.classes[indexPath.row].place
        cell.type.text = presenter?.classes[indexPath.row].type
        cell.timeStartLabel.text = presenter?.classes[indexPath.row].startTime.formatted()
        cell.timeEndLabel.text = presenter?.classes[indexPath.row].endTime.formatted()
        
        let color = UIColor(hexString: presenter?.classes[indexPath.row].backgroundColor ?? "")
        
        cell.contentView.backgroundColor = color
        cell.backgroundColor = color
        
        return cell
    }
    
    //MARK: - Table View DELEGATE
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            storage.removeClassFromStorage(documentId: allClassesWithoutDays[indexPath.row].uniqDocumentId!)
            
            for day in 0...6{
                for index in 0..<allClassesWithDays[day]!.count{
                    if allClassesWithDays[day]![index].uniqDocumentId == allClassesWithoutDays[indexPath.row].uniqDocumentId{
                        allClassesWithDays[day]!.remove(at: index)
                        break
                    }
                }
            }
            
            allClassesWithoutDays.remove(at: indexPath.row)
            
            if allClassesWithoutDays.count != 0 {
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadSections([indexPath.section], with: .automatic)
            }else{
                tableView.reloadSections([indexPath.section], with: .automatic)
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let controllerEdit = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddingClassController") as! NewClassController
                
//        controllerEdit.doAfterAdd = {[self]
//            nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotification,daysDict in
//            
//            let newClass = CellForScheduleModel(course: nameOfCourse, prof: nameOfProf, timeStart: timeStart, timeEnd: timeEnd, place: place, typeOfClass: typeOfClass, backgroundColor: backgroundColor, userNotification: userNotification.rawValue,days:daysDict)
//            storage.removeClassFromStorage(documentId: allClassesWithoutDays[indexPath.row].uniqDocumentId!)
//            let documentId = storage.saveClassesToStorage(cell: newClass)
//            newClass.uniqDocumentId = documentId
//            allClassesWithoutDays[indexPath.row] = newClass
//            
//            newClass.setNotification()
//            
//            for day in 0...6{
//                for index in 0..<allClassesWithDays[day]!.count{
//                    if allClassesWithDays[day]![index].uniqDocumentId == allClassesWithoutDays[indexPath.row].uniqDocumentId{
//                        allClassesWithDays[day]![index] = newClass
//                    }
//                }
//            }
//            tableView.reloadData()
//            
//        }
//        self.navigationController?.pushViewController(controllerEdit, animated: true)
        
    }
    
//    // MARK: - Configure Cell
//    private func configureCell(cell:CellForSchedule,indexPathRow:Int,allCells:[CellForScheduleModel])->CellForSchedule{
//        if allCells.count != 0{
//        let cellModel = allCells[indexPathRow]
//        let dateformatter = DateFormatter()
//        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
//        
//        cell.nameOfProf.text = cellModel.nameOfProf
//        cell.nameOfCourse.text = cellModel.nameOfCourse
//            cell.timeStartLabel.text = "\(dateformatter.string(from: cellModel.timeStart))"
//            cell.timeEndLabel.text = "\(dateformatter.string(from: cellModel.timeEnd))"
//        cell.place.text = cellModel.place
//        cell.type.text = cellModel.typeOfClass
//        
//            cell.nameOfProf.textColor = cellModel.textColor
//            cell.nameOfCourse.textColor = cellModel.textColor
//            cell.timeStartLabel.textColor = cellModel.textColor
//            cell.timeEndLabel.textColor = cellModel.textColor
//            cell.place.textColor = cellModel.textColor
//            cell.type.textColor = cellModel.textColor
//        cell.backgroundColor = UIColor(named: cellModel.backgroundColor.rawValue)
//        }
//        return cell
//    }
    

    // MARK: - configuration TableView
    
    private func setConfigurationTableView(){
        
        self.view.backgroundColor = UIColor(named: "background Color")
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),editButtonItem]
        
        let actionAdd = UIAction { _ in
            let addingController = MainModuleBuilder.createNewClassViewController() as! NewClassController
            
//            addingController.doAfterAdd = { [self]
//                                         nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotification,daysDict in
//                let newClass = CellForScheduleModel(course: nameOfCourse, prof: nameOfProf, timeStart: timeStart, timeEnd: timeEnd, place: place, typeOfClass: typeOfClass, backgroundColor: backgroundColor, userNotification: userNotification.rawValue,days:daysDict)
//                
//                let documentId = storage.saveClassesToStorage(cell: newClass)
//                newClass.uniqDocumentId = documentId
//                
//                newClass.setNotification()
//                
//                for day in 0...6{
//                    if newClass.days[day]!{
//                        allClassesWithDays[day]?.append(newClass)
//                    }
//                }
//                    
//                allClassesWithoutDays.append(newClass)
//                
//                tableView.reloadData()
//            }
            
            self.navigationController?.pushViewController(addingController, animated: true)
        }
        self.navigationItem.rightBarButtonItems?[0].primaryAction = actionAdd
    }

}

extension SettingsClassesController:SettingsClassesProtocol{
    
}
