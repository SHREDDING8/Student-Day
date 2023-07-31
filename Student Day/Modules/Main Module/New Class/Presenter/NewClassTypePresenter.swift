//
//  NewClassTypePresenter.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import Foundation

class NewClassTypePresenter:NewClassAddComponentPresenterProtocol{
    var components: [String]?
    
    var view: NewClassAddComponentViewProtocol?
    
    var storage: ClassesComponentsStorageServiceProtocol?
    
    var model: NewClassModel!
    
    required init(view: NewClassAddComponentViewProtocol, storage: ClassesComponentsStorageServiceProtocol, model: NewClassModel) {
        self.view = view
        self.storage = storage
        self.model = model
    }
    
    func getNavTitle() -> String {
        return "Тип занятия"
    }
    
    func getCurrentComponent() {
        view?.setCurrentComponent(component: model.type)
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
        if let type = component{
            if !(components?.contains(type) ?? false) && !type.isEmpty {
                storage?.writeNewConpmnent(component: type)
            }
            model.type = type
        }
    }
    
    func deleteComponent(index: Int) {
        components?.remove(at: index)
        storage?.deleteComponent(index: index)
    }
    
    
}
