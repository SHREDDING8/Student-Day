//
//  AddedSubjectTeacherPlaceController.swift
//  Student Day
//
//  Created by SHREDDING on 12.10.2022.
//

import UIKit
enum From{
    case Subject
    case Teacher
    case Place
    case type
}

class AddedSubjectTeacherPlaceClassTypeController: UIViewController {
    let storage = Storage()
    
    var arrayHint:[ClassField] = []
    
    var doafterClose:((String)->Void)?
    
    
    
    var cellFrom:From = .Subject
    
    var textField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        
        switch cellFrom{
        case .Place:
            storage.getClassField(get: .place, completion: { [self] classFields in
                arrayHint = classFields
                tableView.reloadData()
            })
        case .Subject:
            storage.getClassField(get: .subject, completion: { [self] classFields in
                arrayHint = classFields
                tableView.reloadData()
            })
        case .Teacher:
            storage.getClassField(get: .teacher, completion: { [self] classFields in
                arrayHint = classFields
                tableView.reloadData()
            })
            
        case .type:
            storage.getClassField(get: .classType, completion: { [self] classFields in
                arrayHint = classFields
                tableView.reloadData()
            })
        }
    }
    
    
    
    // MARK: - Configure controller and elements
    private func configureController(){
        self.view.backgroundColor = UIColor(named: "background Color")
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped)),
            
            editButtonItem
        ]
        self.navigationItem.rightBarButtonItems![1].action = #selector(editButtonTapped)
        
        
        
        switch cellFrom {
        case .Subject:
            self.title = "Предмет"
        case .Teacher:
            self.title = "Преподаватель"
        case .Place:
            self.title = "Место проведения"
        case .type:
            self.title = "Тип занятия"
        }
        
        // textField
        switch cellFrom {
        case .Subject:
            textField.placeholder = "Предмет"
        case .Teacher:
            textField.placeholder = "Преподаватель"
        case .Place:
            textField.placeholder = "Место проведения"
        case .type:
            textField.placeholder = "Тип занятия"
        }
        
        textField.delegate = self
        self.textField.addTarget(self, action: #selector(getNewText), for: .editingChanged)
        
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .orange
        line.layer.cornerRadius = 5
        line.layer.opacity = 0.5
        
        textField.font = UIFont.systemFont(ofSize: 23)
        
        self.view.addSubview(textField)
        self.view.addSubview(line)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),

            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            line.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        
        // table View
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        let nibcell = UINib(nibName: "ChoosingTypeOfClassCell", bundle: nil)
        tableView.register(nibcell, forCellReuseIdentifier: "ChoosingTypeOfClassCell")
        
    }
    
    @objc func editButtonTapped(){
        
        if self.tableView.isEditing{
            self.tableView.setEditing(false, animated: true)
        }else{
            self.tableView.setEditing(true, animated: true)
        }
        
        
    }
    
    
    @objc func saveButtonTapped(){
        
        var getting:ClassFieldType
        
        switch cellFrom {
        case .Subject:
            getting = .subject
        case .Teacher:
            getting = .teacher
        case .Place:
            getting = .place
        case .type:
            getting = .classType
        }
        
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        if let text = textField.text{
            if (text != ""){
                
                storage.getClassField(get: getting) { [self] classFields in
                    classFields.forEach { classField in
                        if classField.ClassFieldText == text{
                            self.navigationController?.popViewController(animated: true)
                            doafterClose?(textField.text ?? "")
                            return
                        }
                    }
                }
                
                storage.saveClassField(classField: ClassField(classFieldType: getting, ClassFieldText: text))
            }
            doafterClose?(textField.text ?? "")
            self.navigationController?.popViewController(animated: true)
        }
    }
}


// MARK: - Table View DELEGATE
extension AddedSubjectTeacherPlaceClassTypeController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayHint.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosingTypeOfClassCell") as! ChoosingTypeOfClassCell
        
        cell.typeOfClassLabel.text = arrayHint[indexPath.row].ClassFieldText
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.textField.text = (tableView.cellForRow(at: indexPath) as! ChoosingTypeOfClassCell).typeOfClassLabel.text
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if tableView.isEditing{
            self.navigationItem.rightBarButtonItems![1].title = "Done"
        }else{
            self.navigationItem.rightBarButtonItems![1].title = "Edit"
        }
        
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            storage.removeClassField(classField: arrayHint[indexPath.row])
            arrayHint.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    
}


// MARK: - Text field Delegate
extension AddedSubjectTeacherPlaceClassTypeController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        
        textField.resignFirstResponder()
        return true
    }
    
    @objc func getNewText(){
        
        var getting:ClassFieldType
        
        switch cellFrom {
        case .Subject:
            getting = .subject
        case .Teacher:
            getting = .teacher
        case .Place:
            getting = .place
        case .type:
            getting = .classType
        }
        
        var storageObjects:[ClassField] = []
        storage.getClassField(get: getting) { classFields in
            storageObjects = classFields
        }
        
        
        var newArrayHint:[ClassField] = []
        
        if let gettedText = textField.text{
            if gettedText == ""{
                arrayHint = storageObjects
                UIView.transition(with: self.tableView, duration: 0.2,options: .transitionCrossDissolve) {
                    self.tableView.reloadData()
                }
                return
            }
            for object in storageObjects{
                if object.ClassFieldText.contains(gettedText){
                    newArrayHint.append(object)
                }
            }
        }
        if newArrayHint.count != arrayHint.count{
            arrayHint = newArrayHint
            UIView.transition(with: self.tableView, duration: 0.2,options: .transitionCrossDissolve) {
                self.tableView.reloadData()
            }
        }
    }
}
