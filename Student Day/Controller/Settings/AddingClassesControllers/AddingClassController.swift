//
//  AddingClassController.swift
//  Student Day
//
//  Created by SHREDDING on 30.09.2022.
//

import UIKit

class AddingClassController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - My variables
    
    var isExitWithSave = false
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var labelOfCellOfChoosingColor: UILabel!
    @IBOutlet weak var typeOfClassCell: UITableViewCell!
    
    
    @IBOutlet weak var subjectOutlet: UITextField!
    
    @IBOutlet weak var nameOfProfOutlet: UITextField!
    
    @IBOutlet weak var placeOutlet: UITextField!
    
    private var nameOfCourse: String = ""

    private var nameOfProf: String = ""

    private var timeStart: Date = Date()
    
    private var timeEnd:Date = Date()

    private var place: String = ""

    private var typeOfClass: TypeClass = .lecture

    private var backgroundColor: backroundColorCell = .noColor

    private var userNotofocation: Bool = true
    
    var doAfterAdd: ((String,String,Date,Date,String,TypeClass,backroundColorCell,Bool)->Void)?

    
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
        case 0,1:
            return 3
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
        }
    }
    
    
    //MARK: - configuration tableView
    
    private func setConfigurationTableView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveClass))
        

        self.placeOutlet.delegate = self
        self.nameOfProfOutlet.delegate = self
        self.subjectOutlet.delegate = self
    }
    
    
    // MARK: - Actions
    
    @IBAction func userNotificationsAction(_ sender: UISwitch) {
        self.userNotofocation = (sender.isOn ? true : false)
    }
    
    @IBAction func timeStartAction(_ sender: UIDatePicker) {
        self.timeStart = sender.date
    }
    @IBAction func timeEndActions(_ sender: UIDatePicker) {
        self.timeEnd = sender.date
    }
    
    @IBAction func subjectAction(_ sender: UITextField) {
        self.nameOfCourse = sender.text ?? ""
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
    }
    
    @IBAction func profAction(_ sender: UITextField) {
        self.nameOfProf = sender.text ?? ""
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
    }
    
    @IBAction func placeAction(_ sender: UITextField) {
        self.place = sender.text ?? ""
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
    }
    
    @objc func saveClass(){
        if tryGetAllTextField(){
            doAfterAdd?(nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotofocation)
            
            isExitWithSave = true
            self.navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Ошибка сохранения", message: "Заполните все поля", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionOk)
            self.present(alert, animated: true)
        }
        
    }
    
    // MARK: - Text field Delegate
    
    private func tryGetAllTextField()->Bool{
        self.nameOfProf = (nameOfProfOutlet.text ?? "").trimmingCharacters(in: .whitespaces)
        self.nameOfCourse = (subjectOutlet.text ?? "").trimmingCharacters(in: .whitespaces)
        self.place = (placeOutlet.text ?? "").trimmingCharacters(in: .whitespaces)
        
        
        if (self.nameOfProf == "" || self.nameOfCourse == "" || self.place == ""){
            return false
        }
        return true
    }
    private func tryGetSomeTextField()->Bool{
        self.nameOfProf = (nameOfProfOutlet.text ?? "").trimmingCharacters(in: .whitespaces)
        self.nameOfCourse = (subjectOutlet.text ?? "").trimmingCharacters(in: .whitespaces)
        self.place = (placeOutlet.text ?? "").trimmingCharacters(in: .whitespaces)
        
        
        if (self.nameOfProf != "" || self.nameOfCourse != "" || self.place != ""){
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
