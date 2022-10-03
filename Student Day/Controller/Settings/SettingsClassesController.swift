//
//  SettingsClassesController.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import UIKit

class SettingsClassesController: UITableViewController {
    
    var isFirstLoad:Bool = true
    let storage = Storage()
    
    var arrayOfClasses:[CellForScheduleModel]?{
        didSet{
            arrayOfClasses = arrayOfClasses?.sorted(by: { $0.timeStart < $1.timeStart })
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()
        arrayOfClasses = storage.getAllClassesFromStorage()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfClasses?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let asd = UINib(nibName: "CellForSchedule", bundle: nil)
        tableView.register(asd, forCellReuseIdentifier: "CellForSchedule")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellForSchedule", for: indexPath) as! CellForSchedule
        if let arrayOfClasses = arrayOfClasses {
            cell = configureCell(cell: cell, indexPathRow: indexPath.row,allCells: arrayOfClasses)
        }
        

        return cell
    }
    private func configureCell(cell:CellForSchedule,indexPathRow:Int,allCells:[CellForScheduleModel])->CellForSchedule{
        if allCells.count != 0{
        let cellModel = allCells[indexPathRow]
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        cell.nameOfProf.text = cellModel.nameOfProf
        cell.nameOfCourse.text = cellModel.nameOfCourse
            cell.timeStartLabel.text = "\(dateformatter.string(from: cellModel.timeStart))"
            cell.timeEndLabel.text = "\(dateformatter.string(from: cellModel.timeEnd))"
        cell.place.text = cellModel.place
        cell.type.text = cellModel.typeOfClass.rawValue
        
            cell.nameOfProf.textColor = cellModel.textColor
            cell.nameOfCourse.textColor = cellModel.textColor
            cell.timeStartLabel.textColor = cellModel.textColor
            cell.timeEndLabel.textColor = cellModel.textColor
            cell.place.textColor = cellModel.textColor
            cell.type.textColor = cellModel.textColor
        cell.backgroundColor = UIColor(named: cellModel.backgroundColor.rawValue)
        }
        return cell
        
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayOfClasses?.remove(at: indexPath.row)
            storage.removeClassFromStorage(indexPath: indexPath)
            
            if arrayOfClasses?.count != 0 {
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadSections([indexPath.section], with: .automatic)
            }else{
                tableView.reloadSections([indexPath.section], with: .automatic)
            }
            
        }
    }



    // MARK: - Navigation

    
    // MARK: - configuration TableView
    
    private func setConfigurationTableView(){
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),editButtonItem]
        
        let actionAdd = UIAction { _ in
            self.tableView.reloadData()
            
            let addingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddingClassController") as! AddingClassController
            addingController.doAfterAdd = { [self]
                                         nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotofocation in
                    let newClass = CellForScheduleModel(course: nameOfCourse, prof: nameOfProf, timeStart: timeStart, timeEnd: timeEnd, place: place, typeOfClass: typeOfClass, backgroundColor: backgroundColor, userNotofocation: userNotofocation)
                    
                arrayOfClasses?.append(newClass)
                storage.saveAllCleseesToStorage([newClass])
                tableView.reloadData()
            }
            
            self.navigationController?.pushViewController(addingController, animated: true)
        }
        
        self.navigationItem.rightBarButtonItems?[0].primaryAction = actionAdd
    }

}
