//
//  ScheduleViewController.swift
//  Student Day
//
//  Created by SHREDDING on 26.09.2022.
//


/*
 TO DO: -
 - Изменить цвета и вид календаря на приятный не забыть темную тему
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
    var calendarHeightConstraint:NSLayoutConstraint!
    
    private var showCloseCalendarButton:UIButton = {
        let button = UIButton()
        button.setTitle("Развернуть", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setNavigationBar()
        setCalendar()
        setButtonShowCloseCalendar()

    }
    

// MARK: - SET VIEW
    
    private func setView(){
        self.view.backgroundColor = UIColor(named: "background Color")
    }
    
    
//MARK: - navigation Bar
    private func setNavigationBar(){
        let editNavItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = editNavItem
        
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
    
    
    
//MARK:- TABLE VIEW
    
    
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
