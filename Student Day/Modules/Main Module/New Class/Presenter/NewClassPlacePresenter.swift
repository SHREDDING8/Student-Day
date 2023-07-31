//
//  NewClassPlacePresenter.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import Foundation

class NewClassPlacePresenter:NewClassAddComponentPresenterProtocol{
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
        return "Место проведения"
    }
    
    func getCurrentComponent() {
        view?.setCurrentComponent(component: model.place)
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
        if let place = component{
            if !(components?.contains(place) ?? false) && !place.isEmpty {
                storage?.writeNewConpmnent(component: place)
            }
            model.place = place
        }
    }
    
    func deleteComponent(index: Int) {
        components?.remove(at: index)
        storage?.deleteComponent(index: index)
    }
}
