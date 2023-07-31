//
//  NewClassAddComponentViewController.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import UIKit

protocol NewClassAddComponentViewProtocol:AnyObject{
    func setCurrentComponent(component:String?)
}

protocol NewClassAddComponentPresenterProtocol:AnyObject{
    
    var components:[String]? { get }
    var view:NewClassAddComponentViewProtocol? { get }
    var storage:ClassesComponentsStorageServiceProtocol? { get }
    var model:NewClassModel! { get }
    
    init(view:NewClassAddComponentViewProtocol, storage:ClassesComponentsStorageServiceProtocol, model:NewClassModel)
    
    func getNavTitle()->String
    
    func getCurrentComponent()
    func loadComponents()
    func getNumberOfcomponents()->Int
    func getComponent(index:Int)->String
    func saveComponent(component:String?)
    func deleteComponent(index:Int)
}


class NewClassAddComponentViewController: UIViewController {
    
    var presenter:NewClassAddComponentPresenterProtocol?
    
    // MARK: - Objects
    
    var textField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Не выбрано"
        
        return textField
    }()
    
    var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var line:UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        line.layer.cornerRadius = 5
        line.layer.opacity = 0.5
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
        addSubviews()
        configureTextFieldAndLine()
        configureTableView()
        
        presenter?.loadComponents()
        presenter?.getCurrentComponent()
        self.navigationItem.title = presenter?.getNavTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.saveComponent(component:self.textField.text)
    }
    
    // MARK: - Configure controller and elements
    private func configureController(){
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
                
        //        self.textField.addTarget(self, action: #selector(getNewHint), for: .editingChanged)
        
    }
    
    fileprivate func addSubviews(){
        self.view.addSubview(self.textField)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.line)
    }
    
    // MARK: - configureTextField
    
    fileprivate func configureTextFieldAndLine(){
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            self.textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            self.textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            self.textField.heightAnchor.constraint(equalToConstant: 50),
            
            self.line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            self.line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.line.heightAnchor.constraint(equalToConstant: 2)
        ])
        
    }
    
    // MARK: - Configure Table View
    
    fileprivate func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let nibcell = UINib(nibName: "NewClassDefaultTableViewCell", bundle: nil)
        tableView.register(nibcell, forCellReuseIdentifier: "NewClassDefaultTableViewCell")
    }
}

// MARK: - Table View Delegate Data Source
extension NewClassAddComponentViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfcomponents() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewClassDefaultTableViewCell", for: indexPath) as! NewClassDefaultTableViewCell
        
        cell.title.text = presenter?.getComponent(index: indexPath.row)
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cell = self.tableView.cellForRow(at: indexPath) as! NewClassDefaultTableViewCell
        self.textField.text = cell.title.text
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if tableView.isEditing{
            self.navigationItem.rightBarButtonItems![0].title = "Done"
        }else{
            self.navigationItem.rightBarButtonItems![0].title = "Edit"
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: nil) { action, view, handler in
            
            self.presenter?.deleteComponent(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        actionDelete.image = UIImage(systemName: "trash")
        actionDelete.title = "Удалить"
        
        let conf = UISwipeActionsConfiguration(actions: [actionDelete])
        return conf
    }
    
        
    @objc func toggleEditMode(){
        self.tableView.isEditing ? self.tableView.setEditing(false, animated: true) : self.tableView.setEditing(true, animated: true)
    }
    
}

extension NewClassAddComponentViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

// MARK: - Protocol functions
extension NewClassAddComponentViewController:NewClassAddComponentViewProtocol{
    func setCurrentComponent(component:String?){
        self.textField.text = component
    }
    
}
