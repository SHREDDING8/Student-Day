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
    
    let storage = Storage()
    private var arrayOfClasses:[CellForScheduleModel]?{
        didSet{
            arrayOfClasses = arrayOfClasses?.sorted(by: { $0.timeStart < $1.timeStart })
        }
    }
    
    // MARK: -  Objects
    
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
    
    
    private var tableViewSchedule:UITableView = {
        let tableViewSchedule = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableViewSchedule.translatesAutoresizingMaskIntoConstraints = false
        return tableViewSchedule
    }()
    var calendarHeightConstraint:NSLayoutConstraint!
    
    private var showCloseCalendarButton:UIButton = {
        let button = UIButton()
        button.setTitle("Развернуть", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private var todayButton:UIButton = {
        let button = UIButton()
        button.setTitle("⟲", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = button.titleLabel?.font.withSize(40)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setCalendar()
        setButtonShowCloseCalendar()
        setConfigurationTableView()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        }
    
    @objc func swipeAction(gesture:UISwipeGestureRecognizer){
        var date:Date = Date.now
        
        if gesture.direction == .right{
            let prevDay = Calendar.current.date(byAdding: DateComponents(day: -1), to: calendarView.selectedDate ?? Date.now)
            calendarView.select(prevDay, scrollToDate: true)
            self.getCurrentClasses(date: prevDay!)
            date = prevDay!
        } else if gesture.direction == .left{
            let nextDay = Calendar.current.date(byAdding: DateComponents(day: 1), to: calendarView.selectedDate ?? Date.now)
            calendarView.select(nextDay, scrollToDate: true)
            self.getCurrentClasses(date: nextDay!)
            date = nextDay!
        }
        
        
        UIView.transition(with: tableViewSchedule, duration: 0.5,options: .transitionCrossDissolve) {
            self.tableViewSchedule.reloadData()
        }
        
        todayButton.isHidden = false
        if date == calendarView.today{
            todayButton.isHidden = true
            calendarView.deselect(date)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentClasses(date: calendarView.selectedDate ?? Date.now)
        UIView.transition(with: tableViewSchedule, duration: 0.5,options: .transitionCrossDissolve) {
            self.tableViewSchedule.reloadData()
        }
        
    }
    

// MARK: - SET VIEW
    
    private func setView(){
        self.view.backgroundColor = UIColor(named: "background Color")
    }
    
    
//MARK: - navigation Bar
    private func setNavigationBar(){
        let settingsNavItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(transitionToSettings))
        self.navigationItem.rightBarButtonItem = settingsNavItem
        
    }
    
    @objc func transitionToSettings(){
        let settingsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsFirstPageController") as! SettingsFirstPageController
        navigationController?.pushViewController(settingsController, animated: true)
    }

//MARK: - CALENDAR
    
    private func setCalendar(){
        
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
    
//MARK: - Button
    private func setButtonShowCloseCalendar(){
        
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
    
    
    @objc private func returnToToday(){
        
                    if let today =  calendarView.today{
                    self.calendarView.setScope(.week, animated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                            if let selected = self.calendarView.selectedDate{
                                self.calendarView.deselect(selected)
                            }
                            self.calendarView.setCurrentPage(today, animated: true)
                            self.getCurrentClasses(date: .now)
        
                            UIView.transition(with: self.tableViewSchedule, duration: 0.5,options: .transitionCrossDissolve) {
                                self.tableViewSchedule.reloadData()
                            }
        
                        })
                        todayButton.isHidden = true
                    }
        
    }
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
    
                        UIView.transition(with: self.tableViewSchedule, duration: 0.5,options: .transitionCrossDissolve) {
                            self.tableViewSchedule.reloadData()
                        }
    
                    })
                    todayButton.isHidden = true
                }
            }
                        
        }
        
    }
    
}

//MARK: - CALENDAR FSCalendarDelegate,FSCalendarDataSource
extension ScheduleViewController:FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calendarView.scope == .week{
            buttonShowCloseTapped()
        }
        self.getCurrentClasses(date: date)
        UIView.transition(with: tableViewSchedule, duration: 0.5,options: .transitionCrossDissolve) {
            self.tableViewSchedule.reloadData()
        }
        
        todayButton.isHidden = false
        if date == calendarView.today{
            todayButton.isHidden = true
            calendarView.deselect(date)
        }
        
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

//MARK: - TABLE VIEW

extension ScheduleViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
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
        controllerEdit.userNotofocation = (arrayOfClasses?[indexPath.row].userNotofocation)!
        controllerEdit.daysDict = (arrayOfClasses?[indexPath.row].days)!
        
        controllerEdit.doAfterAdd = {[self]
            nameOfCourse,nameOfProf,timeStart,timeEnd,place,typeOfClass,backgroundColor,userNotofocation,daysDict in
            
            let newClass = CellForScheduleModel(course: nameOfCourse, prof: nameOfProf, timeStart: timeStart, timeEnd: timeEnd, place: place, typeOfClass: typeOfClass, backgroundColor: backgroundColor, userNotofocation: userNotofocation,days:daysDict)
            
            arrayOfClasses?.remove(at: indexPath.row)
            storage.removeClassFromStorage(indexPath: indexPath)
            arrayOfClasses?.append(newClass)
            storage.saveAllCleseesToStorage([newClass])
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
    // MARK: - Cells for Schedule
    
    private func configureCell(cell:CellForSchedule,indexPathRow:Int,allCells:[CellForScheduleModel])->CellForSchedule{
        if allCells.count != 0{
        let cellModel = allCells[indexPathRow]
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        cell.nameOfProf.text = cellModel.nameOfProf
        cell.nameOfCourse.text = cellModel.nameOfCourse
            cell.timeStartLabel.text = "\(dateformatter.string(from: cellModel.timeStart))"
            cell.timeEndLabel.text = "\(dateformatter.string(from: cellModel.timeEnd))"
        cell.place.text = cellModel.place
        cell.type.text = cellModel.typeOfClass.rawValue
        
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
}
    
    

