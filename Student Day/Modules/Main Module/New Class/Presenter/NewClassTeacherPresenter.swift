//
//  NewClassTeacherPresenter.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import Foundation


class NewClassTeacherPresenter:NewClassAddComponentPresenterProtocol{
    var components: [String]?
    weak var view:NewClassAddComponentViewProtocol?
    
    var storage: ClassesComponentsStorageServiceProtocol?
    
    var model: NewClassModel!
    
    required init(view: NewClassAddComponentViewProtocol, storage: ClassesComponentsStorageServiceProtocol, model: NewClassModel) {
        self.view = view
        self.storage = storage
        self.model = model
    }
    
    func getNavTitle() -> String {
        return "Преподаватель"
    }
    
    func getCurrentComponent() {
        view?.setCurrentComponent(component: model.teacher)
    }
    
    func loadComponents() {
        components = storage?.getAllComponents()
    }
    
    func getNumberOfcomponents() -> Int {
        return components?.count ?? 0
    }
    
    func getComponent(index: Int) -> String {
        return components?[index] ?? ""
    }
    
    func saveComponent(component: String?) {
        if let teacher = component{
            if !(components?.contains(teacher) ?? false) && !teacher.isEmpty {
                storage?.writeNewConpmnent(component: teacher)
            }
            model.teacher = teacher
        }
    }
    
    func deleteComponent(index: Int) {
        components?.remove(at: index)
        storage?.deleteComponent(index: index)
    }
    
}
