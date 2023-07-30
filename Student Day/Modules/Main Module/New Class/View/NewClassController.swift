//
//  NewClassController.swift
//  Student Day
//
//  Created by SHREDDING on 30.09.2022.
//

import UIKit

class NewClassController: UITableViewController, UITextFieldDelegate {
    
    var presenter:NewClassPresenterProtocol?
    
    // MARK: - Controllers
    
    var colorPicker:UIColorPickerViewController!
    
    
    // MARK: - My Fields
    
    public var nameOfCourse: String = "Не выбран"

    public var nameOfProf: String = "Не выбран"

    public var timeStart: Date = Date()
    
    public var timeEnd:Date = Date()

    public var place: String = "Не выбран"

    public var typeOfClass: String = "Не выбран"

    public var backgroundColor: BackroundColorCell = .noColor
    
    // enum from Notifications file
    public var userNotification: notificationTimeBefore = .none
    
    public var daysDict:[Int:Bool] = [
        0:false,
        1:false,
        2:false,
        3:false,
        4:false,
        5:false,
        6:false
    ]
        
    // MARK: - VIEW CONTROLLER FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()
        configurationColorPicker()
    }
    
    
    fileprivate func configurationColorPicker(){
        self.colorPicker = UIColorPickerViewController()
        self.colorPicker.delegate = self
        self.colorPicker.view.backgroundColor = .white
        self.colorPicker.navigationItem.title = "Выбор Цвета"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 3
        case 1:
         return 4
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassWithSubTitleTableViewCell", for: indexPath) as! NewClassWithSubTitleTableViewCell
                cell.title.text = "Предмет"
                cell.subTitle.text = "Не выбрано"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassWithSubTitleTableViewCell", for: indexPath) as! NewClassWithSubTitleTableViewCell
                cell.title.text = "Преподаватель"
                cell.subTitle.text = "Не выбрано"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassWithSubTitleTableViewCell", for: indexPath) as! NewClassWithSubTitleTableViewCell
                cell.title.text = "Тип занятия"
                cell.subTitle.text = "Не выбрано"
                return cell
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassTimeTableViewCell", for: indexPath) as! NewClassTimeTableViewCell
                cell.title.text = "Начало"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassTimeTableViewCell", for: indexPath) as! NewClassTimeTableViewCell
                cell.title.text = "Конец"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassWithSubTitleTableViewCell", for: indexPath) as! NewClassWithSubTitleTableViewCell
                cell.title.text = "Место проведения"
                cell.subTitle.text = "Не выбрано"
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassDefaultTableViewCell", for: indexPath) as! NewClassDefaultTableViewCell
                cell.title.text = "Дни"
                return cell
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassDefaultTableViewCell", for: indexPath) as! NewClassDefaultTableViewCell
                cell.title.text = "Цвет"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassDefaultTableViewCell", for: indexPath) as! NewClassDefaultTableViewCell
                cell.title.text = "Не напоминать"
                return cell
            default:
                break
            }
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    // MARK: - TABLE VIEW DELEGATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 2:
                break
            case 3:
                break
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(self.colorPicker, animated: true)
            case 1:
                let reminderController = NewClassBuilder.createReminderViewController()
                self.navigationController?.pushViewController(reminderController, animated: true)
            default:
                break
            }
            
        default:
            break
        }
        
        
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromTypeClassToChoose"{
            
            let controller = segue.destination as! AddedSubjectTeacherPlaceClassTypeController
            
            controller.cellFrom = .type
            controller.textField.text = self.typeOfClass == "Не выбран" ? "" : self.typeOfClass
            
            controller.doafterClose = {[self]
                typeClass in
                self.typeOfClass = typeClass
            }
            
        }else if segue.identifier == "segueFromColorToChoose"{
            let controller = segue.destination as!ChoosingColorAndTypeController
            controller.cellFrom = .Color
            controller.backroundColor = self.backgroundColor
            controller.doAfterChooseColor = {[self]
                backroundColor in
                self.backgroundColor = backroundColor
                (self.view.viewWithTag(2) as! UITableViewCell).backgroundColor = UIColor(named: backroundColor.rawValue)
                
                if backroundColor.rawValue == "settingsCellColor"{
                }else{
                }
                
            }
            tableView.reloadData()
        }else if segue.identifier == "segueFromDaysToChoose"{
            let controller = segue.destination as!ChoosingColorAndTypeController
            controller.cellFrom = .days
            controller.daysDict = self.daysDict
            controller.doAfterChooseDays = {[self]
                daysDict in
                self.daysDict = daysDict
            }
            
        }
        else if segue.identifier == "reminder"{
            let controller = segue.destination as!ChoosingColorAndTypeController
            controller.cellFrom = .reminder
            controller.reminderChoose = self.userNotification
            controller.doAfterChooseReminder = {[self]
                reminder in
                self.userNotification = reminder
            }
        }else if segue.identifier == "subjectSegue"{
            let controller = segue.destination as! AddedSubjectTeacherPlaceClassTypeController
            
            controller.cellFrom = .Subject
            controller.textField.text = self.nameOfCourse == "Не выбран" ? "" : self.nameOfCourse
            
            controller.doafterClose = {[self]
                subject in
//                self.subjectOutlet.text = subject == "" ? "Не выбран" : subject
            }
        }else if segue.identifier == "placeSegue"{
            let controller = segue.destination as! AddedSubjectTeacherPlaceClassTypeController
            
            controller.cellFrom = .Place
            controller.textField.text = self.place == "Не выбран" ? "" : self.place
            controller.doafterClose = {[self]
                place in
//                self.placeOutlet.text = place == "" ? "Не выбран" : place
            }
        }else if segue.identifier == "teacherSegue"{
            let controller = segue.destination as! AddedSubjectTeacherPlaceClassTypeController
            
            controller.cellFrom = .Teacher
            controller.textField.text = self.nameOfProf == "Не выбран" ? "" : self.nameOfProf
            controller.doafterClose = {[self]
                teacher in
//                self.nameOfProfOutlet.text = teacher == "" ? "Не выбран" : teacher
            }
        }
    }
    
    
    //MARK: - configuration tableView
    
    private func setConfigurationTableView(){
        
        self.navigationItem.title = "Новое занятие"
        
        self.view.backgroundColor = UIColor(named: "background Color")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass))
        
        let defaultCellNib = UINib(nibName: "NewClassDefaultTableViewCell", bundle: nil)
        
        let timeCellNib = UINib(nibName: "NewClassTimeTableViewCell", bundle: nil)
        
        let cellWithSubTitleNib = UINib(nibName: "NewClassWithSubTitleTableViewCell", bundle: nil)
        
        self.tableView.register(defaultCellNib, forCellReuseIdentifier: "NewClassDefaultTableViewCell")
        
        self.tableView.register(timeCellNib, forCellReuseIdentifier: "NewClassTimeTableViewCell")
        
        self.tableView.register(cellWithSubTitleNib, forCellReuseIdentifier: "NewClassWithSubTitleTableViewCell")
    }
    
    
    // MARK: - Actions
    
    @IBAction func timeStartAction(_ sender: UIDatePicker) {
        self.timeStart = sender.date
//        self.timeEndOtutlet.setDate(sender.date, animated: true)
//        self.timeEndOtutlet.minimumDate = sender.date
    }
    @IBAction func timeEndActions(_ sender: UIDatePicker) {
        self.timeEnd = sender.date
    }
    
    @objc func saveClass(){
//        if validationBeforeSave(){
//            
//            timeStart = timeStartOutlet.date
//            timeEnd = timeEndOtutlet.date
//            doAfterAdd?(nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotification,daysDict)
//            self.navigationController?.popViewController(animated: true)
//        }else{
//            let alert = UIAlertController(title: "Ошибка сохранения", message: "Заполните все поля", preferredStyle: .alert)
//            let actionOk = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(actionOk)
//            self.present(alert, animated: true)
//        }
        
    }
    
    // MARK: - Text field Delegate
    
    private func validationBeforeSave()->Bool{
        if (self.nameOfProf == "" || self.nameOfCourse == "" || self.place == ""){
            return false
        }
        
        var daysBool = false
        
        for i in daysDict.values{
            if i == true{
                daysBool = true
            }
        }
        return daysBool
    }
    
}

extension NewClassController:UIColorPickerViewControllerDelegate{
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let colorIndexPath = IndexPath(row: 0, section: 2)
        let colorCell = self.tableView.cellForRow(at: colorIndexPath)
        colorCell?.backgroundColor = viewController.selectedColor
    }
}

extension NewClassController:NewClassViewProtocol{
    
}
