//
//  NewClassReminderTableViewController.swift
//  Student Day
//
//  Created by SHREDDING on 30.07.2023.
//

import UIKit

class NewClassReminderTableViewController: UITableViewController {
    var presenter:NewClassReminderPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Напоминание"
        let cellNib = UINib(nibName: "NewClassDefaultTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "NewClassDefaultTableViewCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getReminderCount() ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassDefaultTableViewCell", for: indexPath) as! NewClassDefaultTableViewCell
        
        cell.title.text = presenter?.getReminderString(index: indexPath.row)
        cell.accessoryType = presenter?.isCurrentReminder(index: indexPath.row) == true ? .checkmark : .none
                                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        presenter?.setReminder(index: indexPath.row)
        
    }
}

extension NewClassReminderTableViewController:NewClassReminderViewProtocol{
    func setCheckmark(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func removeCheckmark(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}
