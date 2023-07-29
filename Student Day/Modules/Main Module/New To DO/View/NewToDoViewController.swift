//
//  NewToDoViewController.swift
//  Student Day
//
//  Created by SHREDDING on 28.02.2023.
//

import UIKit

class NewToDoViewController: UIViewController, UITextFieldDelegate {
    
    var presenter:NewToDoPresenterProtocol?
    
    
    // MARK: - Oblects
    var textField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 23)
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Задача"
        return textField
    }()
    
    let line:UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .orange
        line.layer.cornerRadius = 5
        line.layer.opacity = 0.5
        return line
    }()
    
    let selectSectionTableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .red
        
        return tableView
    }()
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationView()
        setViews()
        setConstaints()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - configurationView
    private func configurationView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        self.title = "New To Do"
        
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .save, target: self, action: nil)
        
        textField.delegate = self
        selectSectionTableView.delegate = self
        selectSectionTableView.dataSource = self
        
        selectSectionTableView.register(UINib(nibName: "ChoosingTypeOfClassCell", bundle: nil), forCellReuseIdentifier: "sectionCell")

    }
    
    private func setViews(){
        self.view.addSubview(textField)
        self.view.addSubview(line)
        self.view.addSubview(selectSectionTableView)
        selectSectionTableView.backgroundColor = .black
    }
    
    // MARK: - setConstaints
    private func setConstaints(){
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),

            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
           
        ])
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            line.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        NSLayoutConstraint.activate([
            self.selectSectionTableView.topAnchor.constraint(equalTo: line.bottomAnchor , constant: 10),
            self.selectSectionTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.selectSectionTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.selectSectionTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - TableView Delegate
extension NewToDoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectSectionTableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! ChoosingTypeOfClassCell
        cell.typeOfClassLabel.text = "Section #\(indexPath.row)"
        return cell
    }
    
    
}

extension NewToDoViewController:NewToDoViewProtocol{
    
}
