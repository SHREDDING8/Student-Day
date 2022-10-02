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
}

class ChoosingColorAndTypeController: UIViewController {
    
    var typeClass:TypeClass = .lecture
    var backroundColor:backroundColorCell = .red
    
    var doAfterChooseType:((TypeClass)->Void)?
    var doAfterChooseColor:((backroundColorCell)->Void)?
    
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
    }
    
    
    
    private func setConfigurationView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        switch cellFrom {
        case .classType:
            self.title = "Тип занятия"
        case .Color:
            self.title = "Цвет"
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
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTypeClass:ChoosingTypeOfClassCell
        let cellColor:setBackgroundColorCell
        
        switch cellFrom{
        case .classType:
            cellTypeClass = (tableView.dequeueReusableCell(withIdentifier: "ChoosingTypeOfClassCell") as! ChoosingTypeOfClassCell)
            cellTypeClass.typeOfClassLabel.text = typeClassArray[indexPath.row]
            if typeClassArray[indexPath.row] == typeClass.rawValue{
                cellTypeClass.accessoryType = .checkmark
            }
            return cellTypeClass
            
        case .Color:
            cellColor = tableView.dequeueReusableCell(withIdentifier: "setBackgroundColorCell")! as! setBackgroundColorCell
            cellColor.backgroundColor = UIColor(named: backroundColorCellArray[indexPath.row])
            if backroundColorCellArray[indexPath.row] == "settingsCellColor" {
                cellColor.chooseColorLabel.textColor = UIColor(named: "gray")

            }else{
                cellColor.chooseColorLabel.textColor =   .white          }
            return cellColor
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch cellFrom{
        case .classType:
            typeClass =  .init(rawValue: typeClassArray[indexPath.row])!
        case .Color:
            backroundColor = .init(rawValue: backroundColorCellArray[indexPath.row])!
        }
        
        navigationController?.popViewController(animated: true)
    }
}
