//
//  AddingClassController.swift
//  Student Day
//
//  Created by SHREDDING on 30.09.2022.
//

import UIKit

class AddingClassController: UITableViewController, UITextFieldDelegate {
    
    
    
    //MARK: - OUTLETS
    
    @IBOutlet private weak var labelOfCellOfChoosingColor: UILabel!
    
    @IBOutlet private weak var colorViewCell: UITableViewCell!
    @IBOutlet private weak var typeOfClassCell: UITableViewCell!
    
    @IBOutlet private weak var timeStartOutlet: UIDatePicker!
    
    @IBOutlet private weak var timeEndOtutlet: UIDatePicker!
    
    
    @IBOutlet private weak var subjectOutlet: UILabel!
    
    @IBOutlet private weak var nameOfProfOutlet: UILabel!
    
    @IBOutlet private weak var placeOutlet: UILabel!
    
    @IBOutlet weak var reminderOutlet: UILabel!
    // MARK: - My Fields
    
    public var nameOfCourse: String = "Не выбран"

    public var nameOfProf: String = "Не выбран"

    public var timeStart: Date = Date()
    
    public var timeEnd:Date = Date()

    public var place: String = "Не выбран"

    public var typeOfClass: TypeClass = .lecture

    public var backgroundColor: backroundColorCell = .noColor

    public var userNotofocation: String = "Не напоминать"
    
    public var daysDict:[Int:Bool] = [
        0:false,
        1:false,
        2:false,
        3:false,
        4:false,
        5:false,
        6:false
    ]
    
    var doAfterAdd: ((String,String,Date,Date,String,TypeClass,backroundColorCell,String,[Int:Bool])->Void)?

    
    // MARK: - VIEW CONTROLLER FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()
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
    
    // MARK: - TABLE VIEW DELEGATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath)
        if selectedCell?.reuseIdentifier == "SubjectCell"{
            subjectOutlet.becomeFirstResponder()
        }else if selectedCell?.reuseIdentifier == "profCell"{
            nameOfProfOutlet.becomeFirstResponder()
        }else if selectedCell?.reuseIdentifier == "placeCell"{
            placeOutlet.becomeFirstResponder()
        }
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromTypeClassToChoose"{
            let controller = segue.destination as! ChoosingColorAndTypeController
            controller.cellFrom = .classType
            controller.typeClass = typeOfClass
            controller.doAfterChooseType = {[self]
                typeClass in
                typeOfClass = typeClass
                (typeOfClassCell.viewWithTag(1) as! UILabel).text = typeOfClass.rawValue
                tableView.reloadData()
                
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
                    labelOfCellOfChoosingColor.textColor = UIColor(named: "gray")
                }else{
                    labelOfCellOfChoosingColor.textColor = .white
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
            controller.reminderChoose = self.userNotofocation
            controller.doAfterChooseReminder = {[self]
                reminder in
                self.userNotofocation = reminder
                self.reminderOutlet.text = reminder
            }
        }else if segue.identifier == "subjectSegue"{
            let controller = segue.destination as! AddedSubjectTeacherPlaceController
            
            controller.cellFrom = .Subject
            controller.textField.text = self.nameOfCourse == "Не выбран" ? "" : self.nameOfCourse
            
            controller.doafterClose = {[self]
                subject in
                self.subjectOutlet.text = subject == "" ? "Не выбран" : subject
                self.nameOfCourse = subject
            }
        }else if segue.identifier == "placeSegue"{
            let controller = segue.destination as! AddedSubjectTeacherPlaceController
            
            controller.cellFrom = .Place
            controller.textField.text = self.place == "Не выбран" ? "" : self.place
            controller.doafterClose = {[self]
                place in
                self.placeOutlet.text = place == "" ? "Не выбран" : place
                self.place = place
            }
        }else if segue.identifier == "teacherSegue"{
            let controller = segue.destination as! AddedSubjectTeacherPlaceController
            
            controller.cellFrom = .Teacher
            controller.textField.text = self.nameOfProf == "Не выбран" ? "" : self.nameOfProf
            controller.doafterClose = {[self]
                teacher in
                self.nameOfProfOutlet.text = teacher == "" ? "Не выбран" : teacher
                self.nameOfProf = teacher
            }
        }
    }
    
    
    //MARK: - configuration tableView
    
    private func setConfigurationTableView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass))
        
        self.nameOfProfOutlet.text = self.nameOfProf
        self.subjectOutlet.text = self.nameOfCourse
        self.placeOutlet.text = self.place
        
        self.timeStartOutlet.date = self.timeStart
        self.timeEndOtutlet.date = self.timeEnd
        (self.typeOfClassCell.viewWithTag(1) as! UILabel).text = self.typeOfClass.rawValue
        self.colorViewCell.backgroundColor = UIColor(named: self.backgroundColor.rawValue)
        self.reminderOutlet.text = self.userNotofocation
        
        if self.backgroundColor.rawValue == "settingsCellColor"{
            labelOfCellOfChoosingColor.textColor = UIColor(named: "gray")
        }else{
            labelOfCellOfChoosingColor.textColor = .white
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func timeStartAction(_ sender: UIDatePicker) {
        self.timeStart = sender.date
        self.timeEndOtutlet.setDate(sender.date, animated: true)
        self.timeEndOtutlet.minimumDate = sender.date
    }
    @IBAction func timeEndActions(_ sender: UIDatePicker) {
        self.timeEnd = sender.date
    }
    
    @objc func saveClass(){
        if validationBeforeSave(){
            doAfterAdd?(nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotofocation,daysDict)
            
            if userNotofocation != "Не напоминать"{
                
                for (weekDayKey, WeekDayValue) in daysDict{
                    if WeekDayValue == true{
                        let notification = Notifications(identifer: nameOfCourse)
                        notification.scheduleNotifications(className: nameOfCourse, timeBeforeClass: userNotofocation, time: timeStart, weekDayClass: weekDayKey)
                    }
                    
                }
                
            }else{
                let notification = Notifications(identifer: nameOfCourse)
                notification.removeNotifications()
            }
            
            self.navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Ошибка сохранения", message: "Заполните все поля", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionOk)
            self.present(alert, animated: true)
        }
        
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
//    private func tryGetSomeTextField()->Bool{
//        
//        if (self.nameOfProf != "" || self.nameOfCourse != "" || self.place != ""){
//            return true
//        }
//        return false
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
