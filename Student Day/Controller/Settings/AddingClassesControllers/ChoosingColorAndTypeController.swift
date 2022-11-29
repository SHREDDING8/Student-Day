//
//  ChoosingColorAndTypeController.swift
//  Student Day
//
//  Created by SHREDDING on 01.10.2022.
//

import UIKit

enum CellFrom{
    case classType
    case Color
    case days
    case reminder
}

class ChoosingColorAndTypeController: UIViewController {
    // notificationTimeBefore from file Notifications
    var reminderChoose:notificationTimeBefore = .none
    
    var typeClass:TypeClass = .lecture
    var backroundColor:backroundColorCell = .red
    var daysDict:[Int:Bool] = [
        0:false,
        1:false,
        2:false,
        3:false,
        4:false,
        5:false,
        6:false
    ]
    
    var doAfterChooseType:((TypeClass)->Void)?
    var doAfterChooseColor:((backroundColorCell)->Void)?
    var doAfterChooseDays:(([Int:Bool])->Void)?
    // notificationTimeBefore from file Notifications
    var doAfterChooseReminder:((notificationTimeBefore)->Void)?
    
    var cellFrom:CellFrom = .classType
    
    private let tableView:UITableView = {
        var tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationView()
        configureTableView()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        doAfterChooseType?(typeClass)
        doAfterChooseColor?(backroundColor)
        doAfterChooseDays?(daysDict)
        doAfterChooseReminder?(reminderChoose)
        
    }
    
    
    
    private func setConfigurationView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        switch cellFrom {
        case .classType:
            self.title = "Тип занятия"
        case .Color:
            self.title = "Цвет"
        case .days:
            self.title = "Дни"
        case .reminder:
            self.title = "Напоминание"
        }
        
    }

    

}

// MARK: - Table View
extension ChoosingColorAndTypeController:UITableViewDelegate, UITableViewDataSource{
    
    private func configureTableView(){
        tableView.backgroundColor = UIColor(named: "background Color")
        self.view.addSubview(self.tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let nibTypeClass = UINib(nibName: "ChoosingTypeOfClassCell", bundle: nil)
        tableView.register(nibTypeClass, forCellReuseIdentifier: "ChoosingTypeOfClassCell")
        let nibColor = UINib(nibName: "setBackgroundColorCell", bundle: nil)
        tableView.register(nibColor, forCellReuseIdentifier: "setBackgroundColorCell")
        
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellFrom{
        case .classType:
            return typeClassArray.count
        case .Color:
            return backroundColorCellArray.count
        case .days:
            return 7
        case .reminder:
            // notificationTimeBefore from file Notifications
            return notificationTimeBefore.reminderDict.count
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTypeClass:ChoosingTypeOfClassCell
        let cellColor:ChoosingTypeOfClassCell
        
        switch cellFrom{
        case .classType:
            cellTypeClass = (tableView.dequeueReusableCell(withIdentifier: "ChoosingTypeOfClassCell") as! ChoosingTypeOfClassCell)
            cellTypeClass.typeOfClassLabel.text = typeClassArray[indexPath.row]
            if typeClassArray[indexPath.row] == typeClass.rawValue{
                cellTypeClass.accessoryType = .checkmark
            }else{
                cellTypeClass.accessoryType = .none
            }
            return cellTypeClass
            
        case .Color:
            cellColor = tableView.dequeueReusableCell(withIdentifier: "ChoosingTypeOfClassCell")! as! ChoosingTypeOfClassCell
            cellColor.backgroundColor = UIColor(named: backroundColorCellArray[indexPath.row])
            
            cellColor.typeOfClassLabel.text = "Выбрать цвет"
            
            if backroundColorCellArray[indexPath.row] == "settingsCellColor" {
                cellColor.typeOfClassLabel.textColor = UIColor(named: "gray")

            }else{
                cellColor.typeOfClassLabel.textColor =   .white  }
            
            if backroundColorCellArray[indexPath.row] == self.backroundColor.rawValue{
                print(backroundColorCellArray[indexPath.row] + "  "  + self.backroundColor.rawValue )
                cellColor.accessoryType = .checkmark
            }else{
                cellColor.accessoryType = .none
            }
            return cellColor
        
        case .days:
            let cellForDay = (tableView.dequeueReusableCell(withIdentifier: "ChoosingTypeOfClassCell") as! ChoosingTypeOfClassCell)
            switch indexPath.row{
                case 0:
                cellForDay.typeOfClassLabel.text = "Понедельник"
            case 1:
                cellForDay.typeOfClassLabel.text = "Вторник"
            case 2:
                cellForDay.typeOfClassLabel.text = "Среда"
            case 3:
                cellForDay.typeOfClassLabel.text = "Четверг"
            case 4:
                cellForDay.typeOfClassLabel.text = "Пятница"
            case 5:
                cellForDay.typeOfClassLabel.text = "Суббота"
            case 6:
                cellForDay.typeOfClassLabel.text = "Воскресенье"
            default:
                break
            }
            if daysDict[indexPath.row]!{
                cellForDay.accessoryType = .checkmark
            }else{
                cellForDay.accessoryType = .none
            }
            return cellForDay
            
            
        case .reminder:
            let cellForRemider = (tableView.dequeueReusableCell(withIdentifier: "ChoosingTypeOfClassCell") as! ChoosingTypeOfClassCell)
            cellForRemider.typeOfClassLabel.text = notificationTimeBefore.reminderArray[indexPath.row]
            if notificationTimeBefore(rawValue: cellForRemider.typeOfClassLabel.text!) == reminderChoose{
                cellForRemider.accessoryType = .checkmark
            }else{
                cellForRemider.accessoryType = .none
            }
            
            return cellForRemider
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch cellFrom{
        case .classType:
            typeClass =  .init(rawValue: typeClassArray[indexPath.row])!
            navigationController?.popViewController(animated: true)
        case .Color:
            backroundColor = .init(rawValue: backroundColorCellArray[indexPath.row])!
            navigationController?.popViewController(animated: true)
        case .days:
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.cellForRow(at: indexPath)?.accessoryType = (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) ? .none : .checkmark
            daysDict[indexPath.row] = daysDict[indexPath.row]! ? false : true
        case .reminder:
            tableView.deselectRow(at: indexPath, animated: true)
            reminderChoose = notificationTimeBefore(rawValue: notificationTimeBefore.reminderArray[indexPath.row])!
            self.navigationController?.popViewController(animated: true)
        }
    
        
        
    }
}
