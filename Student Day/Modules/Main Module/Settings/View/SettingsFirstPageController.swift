//
//  SettingsFirstPageController.swift
//  Student Day
//
//  Created by SHREDDING on 28.09.2022.
//

import UIKit

class SettingsFirstPageController: UITableViewController {
    
    var presenter:SettingsFirstPagePresenterProtocol?
    
    private enum CellsText{
        static let classes = ("Занятия","Добавьте, удалите или измените свои занятия")
        static let events = ("События","Добавьте, удалите или измените свои события")
        
        static let newSection = ("Новый раздел","Добавьте, удалите или измените свои домашние задания")
        static let NewSomething = ("Новое дело","Добавьте, удалите или измените свои дела")
        
        static let NewHomeWork = ("Новое домашние задание","Добавьте, удалите или измените свои домашние задания")
    }
    
    init() {
        super.init(style: .insetGrouped)
        self.tableView.separatorColor = .systemIndigo
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0: return "Расписание"
        case 1: return "To Do"
        default: return nil
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell",for: indexPath) as! SettingsTableViewCell
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                cell.title.text = CellsText.classes.0
                cell.subTitile.text = CellsText.classes.1
            case 1:
                cell.title.text = CellsText.events.0
                cell.subTitile.text = CellsText.events.1
            default: return UITableViewCell()
            }
        case 1:
            switch indexPath.row{
            case 0:
                cell.title.text = CellsText.newSection.0
                cell.subTitile.text = CellsText.newSection.1
            case 1:
                cell.title.text = CellsText.NewSomething.0
                cell.subTitile.text = CellsText.NewSomething.1
            case 2:
                cell.title.text = CellsText.NewHomeWork.0
                cell.subTitile.text = CellsText.NewHomeWork.1
            default: return UITableViewCell()
            }
        default: return UITableViewCell()
        }
        
        return cell
    }
    
    
    //MARK: - Table view Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                let allClasses = MainModuleBuilder.createAllClassesViewController()
                self.navigationController?.pushViewController(allClasses, animated: true)
            case 1:
                break
            default: break
            }
        case 1:
            switch indexPath.row{
            case 0:
                break
            case 1:
                break
            case 2:
                break
            default: break
            }
        default: break
        }
        
        
    }
    
    //MARK: - confugiration table view
    
    private func setConfigurationTableView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        self.title = "Настройки"
        
        let cellNib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
}

extension SettingsFirstPageController:SettingsFirstPageControllerProtocol{
    
}


