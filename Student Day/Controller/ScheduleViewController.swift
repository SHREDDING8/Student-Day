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
        let tableViewSchedule = UITableView()
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
    
    var asd:UINib?
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setCalendar()
        setButtonShowCloseCalendar()
        setConfigurationTableView()
        
        

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
        let settingsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsFirstPageController")
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
        
        
        NSLayoutConstraint.activate([
            showCloseCalendarButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            showCloseCalendarButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            showCloseCalendarButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        showCloseCalendarButton.addTarget(nil, action: #selector(buttonShowCloseTapped), for: .touchUpInside)
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
            
            
            if let today =  calendarView.today{
                    calendarView.setScope(.week, animated: false)
                let month = Calendar.current.date(byAdding: .month, value: 1, to: today)!
                calendarView.setCurrentPage(month, animated: false)
                    calendarView.setCurrentPage(today, animated: true)
               
            }
            UIView.transition(with: showCloseCalendarButton , duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.showCloseCalendarButton.setTitle( "Развернуть", for: .normal)
            }, completion: nil)
            if let selected = calendarView.selectedDate{
                calendarView.deselect(selected)
            }
            
        }
    }
    
}

//MARK: - CALENDAR FSCalendarDelegate,FSCalendarDataSource
extension ScheduleViewController:FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            self.calendarView.setScope(.month, animated: true)
        
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
}

//MARK:- TABLE VIEW

extension ScheduleViewController:UITableViewDelegate,UITableViewDataSource{
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        asd = UINib(nibName: "CellForSchedule", bundle: nil)
        tableView.register(asd, forCellReuseIdentifier: "CellForSchedule")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellForSchedule", for: indexPath) as! CellForSchedule
        
        cell = configureCell(cell: cell, indexPathRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Cells for Schedule
    
    private func configureCell(cell:CellForSchedule,indexPathRow:Int)->CellForSchedule{
        let gfd = test()
        let cellModel = gfd[indexPathRow]
        let dateformatter = DateFormatter()
        dateformatter.setLocalizedDateFormatFromTemplate("HH:mm")
        
        cell.nameOfProf.text = cellModel.nameOfProf
        cell.nameOfCourse.text = cellModel.nameOfCourse
        cell.time.text = dateformatter.string(from: cellModel.time)
        cell.place.text = cellModel.place
        cell.type.text = cellModel.typeOfClass.rawValue
        
        cell.backgroundColor = UIColor(named: cellModel.backgroundColor.rawValue)
        
        return cell
        
    }
    
    
}
