//
//  SettingsClassesController.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import UIKit

class SettingsClassesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()

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
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let asd = UINib(nibName: "CellForSchedule", bundle: nil)
        tableView.register(asd, forCellReuseIdentifier: "CellForSchedule")
        let storage = Storage()
        let allcells = storage.getAllClassesFromStorage()
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellForSchedule", for: indexPath) as! CellForSchedule
        if let allcells = allcells {
            cell = configureCell(cell: cell, indexPathRow: indexPath.row,allCells: allcells)
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
        cell.time.text = dateformatter.string(from: cellModel.time)
        cell.place.text = cellModel.place
        cell.type.text = cellModel.typeOfClass.rawValue
        
        cell.backgroundColor = UIColor(named: cellModel.backgroundColor.rawValue)
        }
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - configuration TableView
    
    private func setConfigurationTableView(){
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)]
        
        let action = UIAction { _ in
            print(0000)
            let storage = Storage()
            storage.saveAllCleseesToStorage(test())
            self.tableView.reloadData()
        }
        
        self.navigationItem.rightBarButtonItems?[0].primaryAction = action
    }

}
