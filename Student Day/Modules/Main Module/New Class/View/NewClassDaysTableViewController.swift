//
//  NewClassDaysTableViewController.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import UIKit

class NewClassDaysTableViewController: UITableViewController {
    
    var presenter:NewClassDaysPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Дни"
        let cellNib = UINib(nibName: "NewClassDefaultTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "NewClassDefaultTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.getCountDays() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassDefaultTableViewCell", for: indexPath) as! NewClassDefaultTableViewCell
        cell.title.text = presenter?.getDayString(index: indexPath.row)
        
        cell.accessoryType = presenter?.getDayIsSelected(index: indexPath.row) == true ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        presenter?.dayTapped(indexPath: indexPath)
    }
    
}


extension NewClassDaysTableViewController:NewClassDaysViewProtocol{
    func changeAccesoryType(toChange: [IndexPath : Bool]) {
        for (key,value) in toChange{
            let cell = self.tableView.cellForRow(at: key)
            cell?.accessoryType = value == true ? .checkmark : .none
        }
    }
    
}
