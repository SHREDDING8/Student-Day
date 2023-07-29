//
//  ToDoViewController.swift
//  Student Day
//
//  Created by SHREDDING on 27.02.2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var presenter:ToDoViewPresenterProtocol?
    
    // MARK: - Variables & Constants
    
    var sectionTitles:[SectionToDo] = []
    
    // MARK: - Outlets & views
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    private var newTodoButton:UIButton = {
        let button = CustomButton(type: .system)
        
        let imgConf = UIImage.SymbolConfiguration(pointSize: 60, weight: .light, scale: .small)
        button.tintColor = .white
        
        
        button.setImage(UIImage(systemName: "plus",withConfiguration: imgConf), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(nil, action: #selector(transitionToNewToDo), for: .touchUpInside)
        
        
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        configurationView()
        setConstaints()
        registerCells()
    }
    
    
    // MARK: - Configuration View
    
    private func configurationView(){
        self.view.backgroundColor = UIColor(named: "background Color")
        self.title = "To Do manager"
        
        let settingsNavItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(transitionToSettings))
        self.navigationItem.rightBarButtonItem = settingsNavItem
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeLeftGesture.direction = .left
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeRightGesture.direction = .right
        
        self.view.addGestureRecognizer(swipeLeftGesture)
        self.view.addGestureRecognizer(swipeRightGesture)
        
    }
    
    // MARK: - Set Views
    
    private func setViews(){
        self.view.addSubview(newTodoButton)
    }
    
    // MARK: - Set Constraints
    private func setConstaints(){
        NSLayoutConstraint.activate([
            newTodoButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newTodoButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    
    // MARK: - Register Cells
    private func registerCells(){
        let toDoCellNib = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        tableView.register(toDoCellNib, forCellReuseIdentifier: "ToDoTableViewCell")
    }
    
    
    // MARK: - Actions
    @objc private func viewSwipe(gesture:UISwipeGestureRecognizer){
        switch gesture.direction{
        case .left:
            segmentControl.selectedSegmentIndex = 1
        case .right:
            segmentControl.selectedSegmentIndex = 0
        default:
            break
        }
    }
    
    
    @objc fileprivate func transitionToSettings(){
        let settingsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsFirstPageController") as! SettingsFirstPageController
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    
    // MARK: - Alert Settings
    @IBAction func transitionToNewToDo(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Добавить", message: nil , preferredStyle: .actionSheet)
        
        let newSection = UIAlertAction(title: "Новый раздел", style: .default){ _ in
            let newSectionAlert = UIAlertController(title: "Новый раздел", message:"Введите название", preferredStyle: .alert)
            
            newSectionAlert.addTextField()
            
            let addAction = UIAlertAction(title: "Добавить", style: .default){ [self]_ in
                if !(newSectionAlert.textFields?[0].text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty)!{
                    let newSection = SectionToDo(title: (newSectionAlert.textFields?[0].text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")))!)
                    
                    sectionTitles.append(newSection)
                    tableView.reloadData()
                }
            }
            let cancel = UIAlertAction(title: "Отменить", style: .cancel)
            
            newSectionAlert.addAction(addAction)
            newSectionAlert.addAction(cancel)
            self.present(newSectionAlert, animated: true)
        }
        
        let removeSection = UIAlertAction(title: "Удалить или изменить раздел", style: .default){ [self]
            _ in
            tableView.setEditing(true, animated: true)
        }
        
        let newToDo = UIAlertAction(title: "new To Do", style: .default) { _ in
            
            let newToDoVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewToDoViewController") as! NewToDoViewController
            self.navigationController?.pushViewController(newToDoVc, animated: true)
            
        }
        let newHomeWork = UIAlertAction(title: "new Homework", style: .default) { _ in
            
            let newToDoVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewToDoViewController") as! NewToDoViewController
            self.navigationController?.pushViewController(newToDoVc, animated: true)
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addAction(newSection)
        alertController.addAction(removeSection)
        alertController.addAction(newToDo)
        alertController.addAction(newHomeWork)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
    
}


// MARK: - Table view

extension ToDoViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! ToDoTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        var menuSectionItems: [UIMenuElement] {
            return [
                UIAction(title: "Rename Section", image: UIImage(systemName: "square.and.pencil"), handler: { (_) in
                }),
                UIAction(title: "Edit section", image: UIImage(systemName: "ellipsis.circle"), handler: { (_) in
                }),
                UIAction(title: "Delete section..", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
                })
            ]
        }
        
        var menuSection: UIMenu {
            return UIMenu(title: sectionTitles[section].getTitle() , image: nil, identifier: nil, options: [], children: menuSectionItems)
        }
        
        
        
        let view = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
       
        label.text = sectionTitles[section].getTitle()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonEdit = UIButton.systemButton(with:  UIImage(systemName: "gearshape")!, target: self, action: nil)
        buttonEdit.tintColor = .black
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        buttonEdit.menu = menuSection
        buttonEdit.showsMenuAsPrimaryAction = true
        
        view.addSubview(label)
        view.addSubview(buttonEdit)

        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonEdit.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
            buttonEdit.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ToDoViewController:ToDoViewControllerProtocol{
    
}
