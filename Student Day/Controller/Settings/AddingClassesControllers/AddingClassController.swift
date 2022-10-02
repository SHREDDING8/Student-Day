//
//  AddingClassController.swift
//  Student Day
//
//  Created by SHREDDING on 30.09.2022.
//

import UIKit

class AddingClassController: UITableViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var labelOfCellOfChoosingColor: UILabel!
    @IBOutlet weak var typeOfClassCell: UITableViewCell!
    
    
    
    private var nameOfCourse: String = ""

    private var nameOfProf: String = ""

    private var timeStart: Date = Date()
    
    private var timeEnd:Date = Date()

    private var place: String = ""

    private var typeOfClass: TypeClass = .lecture

    private var backgroundColor: backroundColorCell = .noColor

    private var userNotofocation: Bool = true
    
    var doAfterAdd: ((String,String,Date,Date,String,TypeClass,backroundColorCell,Bool)->Void)?

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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
    }
    

}
