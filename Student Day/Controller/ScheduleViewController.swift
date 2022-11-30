//
//  ScheduleViewController.swift
//  Student Day
//
//  Created by SHREDDING on 26.09.2022.
//


/*
 TO DO: -
 */

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController {
    
    // MARK: - Storage
    
    let storage = Storage()
    private var arrayOfClasses:[CellForScheduleModel]?{
        didSet{
            arrayOfClasses = arrayOfClasses?.sorted(by: { $0.timeStart < $1.timeStart })
        }
    }
    
    // MARK: -  Calendar
    
    private var calendarView:FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.firstWeekday = 2
        calendar.scope = .week
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.locale = NSLocale(localeIdentifier: "ru") as Locale
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM YYYY")
        // set template after setting locale
        calendar.appearance.headerDateFormat = dateFormatter.string(from: calendar.currentPage)
        
        
        
        //settings color
        calendar.appearance.headerTitleColor = UIColor(named: "gray")
        calendar.appearance.weekdayTextColor = UIColor(named: "gray")
        calendar.appearance.titleWeekendColor = .systemGray
        calendar.appearance.titlePlaceholderColor = .systemGray3
        
        calendar.appearance.titleDefaultColor = UIColor(named: "black")
        
        calendar.appearance.selectionColor = .systemOrange
        
        calendar.appearance.borderSelectionColor = .systemBlue
        
        calendar.appearance.todayColor = .systemBlue
        
        // settings Font
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        
        return calendar
    }()
    var calendarHeightConstraint:NSLayoutConstraint!
    
    // MARK: - TableView
    
    private var tableViewSchedule:UITableView = {
        let tableViewSchedule = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableViewSchedule.translatesAutoresizingMaskIntoConstraints = false
        return tableViewSchedule
    }()
    
    
    // MARK: - Buttons
    
    private var showCloseCalendarButton:UIButton = {
        let button = UIButton()
        button.setTitle("Развернуть", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //reset button
    private var todayButton:UIButton = {
        let button = UIButton()
        button.setTitle("⟲", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = button.titleLabel?.font.withSize(40)
        return button
    }()
    
    
    // MARK: - Live Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setCalendar()
        setButtonShowCloseCalendar()
        setConfigurationTableView()
        
        // swipes left and right to change day in calendar
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // updates the table with Classes/Courses
        getCurrentClasses(date: calendarView.selectedDate ?? Date.now)
        reloadData()
    }
    
    
    // MARK: - Set Settings
    
    /**
     this function set settings on main View
     
     */
    fileprivate func setView(){
        self.view.backgroundColor = UIColor(named: "background Color")
    }
    
    
    /**
     This function Configure the table View
     
     */
    fileprivate func setConfigurationTableView(){
        
        tableViewSchedule.backgroundColor = UIColor(named: "background Color")
        
        self.tableViewSchedule.delegate = self
        self.tableViewSchedule.dataSource = self
        self.view.addSubview(tableViewSchedule)
        NSLayoutConstraint.activate([
            
            tableViewSchedule.topAnchor.constraint(equalTo: showCloseCalendarButton.bottomAnchor, constant: 10),
            tableViewSchedule.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableViewSchedule.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableViewSchedule.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        getCurrentClasses(date: calendarView.selectedDate ?? Date.now)
    }
    
    
    /**
     this function set settings on navigation Bar
     
     */
    fileprivate func setNavigationBar(){
        let settingsNavItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(transitionToSettings))
        self.navigationItem.rightBarButtonItem = settingsNavItem
        
    }
    
    /**
     This function set settings on FScalendar
     
     */
    fileprivate func setCalendar(){
        
        self.view.addSubview(calendarView)
        
         calendarHeightConstraint = NSLayoutConstraint(item: calendarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendarView.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)]
        )
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    /**
     This function set settings on Show/Close button
     
     */
    fileprivate func setButtonShowCloseCalendar(){
        
        self.view.addSubview(showCloseCalendarButton)
        
        self.view.addSubview(todayButton)
        
        
        NSLayoutConstraint.activate([
            showCloseCalendarButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            showCloseCalendarButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            showCloseCalendarButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            todayButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            todayButton.heightAnchor.constraint(equalToConstant: 20),
            todayButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        ])
        
        showCloseCalendarButton.addTarget(nil, action: #selector(buttonShowCloseTapped), for: .touchUpInside)
        todayButton.addTarget(self, action: #selector(returnToToday), for: .touchUpInside)
        todayButton.isHidden = true
    }
    
    /**
     This function configure the cell for table View
     
     
     **parameters:**
     - cell:CellForSchedule - Cell object
     - indexPathRow:Int - index cell
     - allCells:[CellForScheduleModel] - array with all cells with Classes/Courses
     
     
     **return**
     - CellForSchedule
     */
    fileprivate func configureCell(cell:CellForSchedule,indexPathRow:Int,allCells:[CellForScheduleModel])->CellForSchedule{
        if allCells.count != 0{
        let cellModel = allCells[indexPathRow]
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        cell.nameOfProf.text = cellModel.nameOfProf
        cell.nameOfCourse.text = cellModel.nameOfCourse
            cell.timeStartLabel.text = "\(dateformatter.string(from: cellModel.timeStart))"
            cell.timeEndLabel.text = "\(dateformatter.string(from: cellModel.timeEnd))"
        cell.place.text = cellModel.place
        cell.type.text = cellModel.typeOfClass
        
            cell.nameOfProf.textColor = cellModel.textColor
            cell.nameOfCourse.textColor = cellModel.textColor
            cell.timeStartLabel.textColor = cellModel.textColor
            cell.timeEndLabel.textColor = cellModel.textColor
            cell.place.textColor = cellModel.textColor
            cell.type.textColor = cellModel.textColor
        cell.backgroundColor = UIColor(named: cellModel.backgroundColor.rawValue)
        }
        return cell
        
    }
    
    
    // MARK: - Actions
    
    /**
     this function push to avigation controller the page with settings
     
     
     */
    @objc fileprivate func transitionToSettings(){
        let settingsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsFirstPageController") as! SettingsFirstPageController
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    /**
     this function work with swipe and change day (next or prev)
     
     
     **parameters:**
     - gesture:UISwipeGestureRecognizer: - swipe Gesture
     */
    @objc func swipeAction(gesture:UISwipeGestureRecognizer){
        var date:Date = Date.now
        var nextOrPrevDay:Date?
        var addingDays = 0
        
        switch gesture.direction{
        case .right:
            addingDays = -1
        case .left:
            addingDays = 1
        default:
            break
        }
        
        nextOrPrevDay = Calendar.current.date(byAdding: DateComponents(day: addingDays), to: calendarView.selectedDate ?? Date.now)
        
        calendarView.select(nextOrPrevDay, scrollToDate: true)
        self.getCurrentClasses(date: nextOrPrevDay!)
        
    
        reloadData()
        
        onOffResetButton(date)
    }
    
    /**
     thist function return calendar on the current day
     
     */
    @objc private func returnToToday(){
        
            if let today =  calendarView.today{
            self.calendarView.setScope(.week, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                    if let selected = self.calendarView.selectedDate{
                        self.calendarView.deselect(selected)
                    }
                    self.calendarView.setCurrentPage(today, animated: true)
                    self.getCurrentClasses(date: .now)

                    self.reloadData()

                })
                todayButton.isHidden = true
            }
        }
    
    /**
     This function processes the tap on button Show/Clouse Calendar
     
     */
    @objc private func buttonShowCloseTapped(){
        if calendarView.scope == .week{
            // change the scope
            calendarView.setScope(.month, animated: true)
            
            // change the text of button
            UIView.transition(with: showCloseCalendarButton , duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.showCloseCalendarButton.setTitle( "Скрыть", for: .normal)
            }, completion: nil)
        }else{
            self.calendarView.setScope(.week, animated: true)
            UIView.transition(with: showCloseCalendarButton , duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.showCloseCalendarButton.setTitle( "Развернуть", for: .normal)
            }, completion: nil)
            
            if arrayOfClasses?.count == 0{
                if let today =  calendarView.today{
                self.calendarView.setScope(.week, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                        if let selected = self.calendarView.selectedDate{
                            self.calendarView.deselect(selected)
                        }
                        self.calendarView.setCurrentPage(today, animated: true)
                        self.getCurrentClasses(date: .now)
    
                        self.reloadData()
    
                    })
                    todayButton.isHidden = true
                }
            }
                        
        }
        
    }
    
    
    
    // MARK: - Other functions
    
    /**
     this function check the current date and selected date
     
     if they are different function shows tha Reset Button
     
     
     **parameters:**
     - date: The selected Date
     */
    fileprivate func onOffResetButton(_ date: Date) {
        todayButton.isHidden = false
        if date == calendarView.today{
            todayButton.isHidden = true
            calendarView.deselect(date)
        }
    }
    
    /**
     this function updates the table view
     
     */
    fileprivate func reloadData() {
        UIView.transition(with: tableViewSchedule, duration: 0.5,options: .transitionCrossDissolve) {
            self.tableViewSchedule.reloadData()
        }
    }
}



//MARK: -  Extension FSCALENDAR DELEGATE
extension ScheduleViewController:FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calendarView.scope == .week{
            buttonShowCloseTapped()
        }
        self.getCurrentClasses(date: date)
        reloadData()
        
        onOffResetButton(date)
        
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // change the month
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM YYYY")
        
        calendar.appearance.headerDateFormat = dateFormatter.string(from: calendar.currentPage)
    }
    
    private func getCurrentClasses(date:Date){
        let myCalendar = Calendar(identifier: .gregorian)
        var weekDay = myCalendar.component(.weekday, from: date) - 2
        if weekDay == -1{
            weekDay = 6
        }
        let allClasses = storage.getAllClassesFromStorage()
        arrayOfClasses = []
        allClasses?.forEach({ cell in
            if cell.days[weekDay]!{
                arrayOfClasses?.append(cell)
            }
        })
    }
}

//MARK: - Extension TABLE VIEW

extension ScheduleViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfClasses!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let CellForScheduleNib = UINib(nibName: "CellForSchedule", bundle: nil)
        tableView.register(CellForScheduleNib, forCellReuseIdentifier: "CellForSchedule")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellForSchedule", for: indexPath) as! CellForSchedule
        
        cell = configureCell(cell: cell, indexPathRow: indexPath.row,allCells: arrayOfClasses!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controllerEdit = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddingClassController") as! AddingClassController
        
        controllerEdit.nameOfProf = (arrayOfClasses?[indexPath.row].nameOfProf)!
        controllerEdit.nameOfCourse = (arrayOfClasses?[indexPath.row].nameOfCourse)!
        controllerEdit.timeStart = (arrayOfClasses?[indexPath.row].timeStart)!
        controllerEdit.timeEnd = (arrayOfClasses?[indexPath.row].timeEnd)!
        controllerEdit.place = (arrayOfClasses?[indexPath.row].place)!
        controllerEdit.typeOfClass = (arrayOfClasses?[indexPath.row].typeOfClass)!
        controllerEdit.backgroundColor = (arrayOfClasses?[indexPath.row].backgroundColor)!
        controllerEdit.userNotification = notificationTimeBefore(rawValue: (arrayOfClasses?[indexPath.row].userNotification)!)!
        controllerEdit.daysDict = (arrayOfClasses?[indexPath.row].days)!
        
        controllerEdit.doAfterAdd = {[self]
            nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotification,daysDict in
            
            let newClass = CellForScheduleModel(course: nameOfCourse, prof: nameOfProf, timeStart: timeStart, timeEnd: timeEnd, place: place, typeOfClass: typeOfClass, backgroundColor: backgroundColor, userNotification: userNotification.rawValue,days:daysDict)
            
            arrayOfClasses?.remove(at: indexPath.row)
            storage.removeClassFromStorage(indexPath: indexPath)
            arrayOfClasses?.append(newClass)
            storage.saveClassesToStorage([newClass])
            tableView.reloadData()
            
        }
        self.navigationController?.pushViewController(controllerEdit, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableViewSchedule{
            if calendarView.scope == .month{
                buttonShowCloseTapped()
            }
        }
        
    }
}
