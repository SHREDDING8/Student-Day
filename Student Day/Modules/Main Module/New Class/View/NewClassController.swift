//
//  NewClassController.swift
//  Student Day
//
//  Created by SHREDDING on 30.09.2022.
//

import UIKit
import UIColor_Extensions
import AlertKit

class NewClassController: UITableViewController, UITextFieldDelegate {
    
    var presenter:NewClassPresenterProtocol?
    
    // MARK: - Controllers
    
    var colorPicker:UIColorPickerViewController!
    
    // MARK: - VIEW CONTROLLER FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationTableView()
        configurationColorPicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getReminderString()
        presenter?.getTitleString()
        presenter?.getTeacherString()
        presenter?.getTypeString()
        presenter?.getPlaceString()
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
                cell.time.addAction(UIAction(handler: { _ in
                    self.presenter?.setStartTime(time: cell.time.date)
                }), for: .valueChanged)
                presenter?.setStartTime(time: cell.time.date)
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassTimeTableViewCell", for: indexPath) as! NewClassTimeTableViewCell
                cell.title.text = "Конец"
                
                cell.time.addAction(UIAction(handler: { _ in
                    self.presenter?.setEndTime(time: cell.time.date)
                }), for: .valueChanged)
                
                self.presenter?.setEndTime(time: cell.time.date)
                
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
                
                presenter?.setBackgroundColor(hex: cell.backgroundColor?.toHex() ?? UIColor.gray.toHex())
                
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
                let titleController = NewClassBuilder.createTitleViewController()
                self.navigationController?.pushViewController(titleController, animated: true)
            case 1:
                let teacherController = NewClassBuilder.createTeacherViewController()
                self.navigationController?.pushViewController(teacherController, animated: true)
            case 2:
                let typeController = NewClassBuilder.createTypeViewController()
                self.navigationController?.pushViewController(typeController, animated: true)
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 2:
                let placeController = NewClassBuilder.createPlaceViewController()
                self.navigationController?.pushViewController(placeController, animated: true)
            case 3:
                let daysController = NewClassBuilder.createDaysViewController()
                self.navigationController?.pushViewController(daysController, animated: true)
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
    
        
    @objc func saveClass(){
        presenter?.saveClass()
    }
    
}

extension NewClassController:UIColorPickerViewControllerDelegate{
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let colorIndexPath = IndexPath(row: 0, section: 2)
        let colorCell = self.tableView.cellForRow(at: colorIndexPath)
        presenter?.setBackgroundColor(hex: viewController.selectedColor.toHex())
        colorCell?.backgroundColor = viewController.selectedColor
    }
}

extension NewClassController:NewClassViewProtocol{
    func setReminderString(reminderString: String) {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as! NewClassDefaultTableViewCell
        cell.title.text = reminderString
    }
    
    func setTitleString(title:String){
        print("title")
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! NewClassWithSubTitleTableViewCell
        cell.subTitle.text = title
    }
    
    func setTeacherString(teacherString:String){
        print("teacherString")
        let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! NewClassWithSubTitleTableViewCell
        cell.subTitle.text = teacherString
    }
    
    func setTypeString(typeString:String){
        print("typeString")
        let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! NewClassWithSubTitleTableViewCell
        cell.subTitle.text = typeString
    }
    
    func setPlaceString(placeString:String){
        print("placeString")
        let cell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 1)) as! NewClassWithSubTitleTableViewCell
        cell.subTitle.text = placeString
    }
    
    func showErrorSave() {
        // MARK: - TODO передалать в alert Services
        let alert = UIAlertController(title: "Ошибка сохранения", message: "Заполните все необходимые поля\nНазвание\nДни", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOk)
        self.present(alert, animated: true)
    }
    
    func succsessfullSave() {
        AlertKitAPI.present(
            title: "Успешно сохранено",
            icon: .done,
            style: .iOS17AppleMusic
        )
        self.navigationController?.popViewController(animated: true)
    }
    
}
