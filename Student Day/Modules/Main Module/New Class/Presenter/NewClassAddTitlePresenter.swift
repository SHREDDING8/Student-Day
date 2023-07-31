//
//  NewClassAddTitlePresenter.swift
//  Student Day
//
//  Created by SHREDDING on 31.07.2023.
//

import Foundation


class NewClassAddTitlePresenter:NewClassAddComponentPresenterProtocol{
    var components: [String]?
    weak var view:NewClassAddComponentViewProtocol?
    
    var storage:ClassesComponentsStorageServiceProtocol?
    var model:NewClassModel!
    
    required init(view:NewClassAddComponentViewProtocol, storage:ClassesComponentsStorageServiceProtocol, model:NewClassModel) {
        self.view = view
        self.storage = storage
        self.model = model
    }
    
    func getNavTitle()->String{
        return "Предмет"
    }
    
    func getCurrentComponent(){
        view?.setCurrentComponent(component:model.title)
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
        if let title = component{
            if !(components?.contains(title) ?? false) && !title.isEmpty {
                storage?.writeNewConpmnent(component: title)
            }
            model.title = title
        }
    }
    
    func deleteComponent(index:Int){
        components?.remove(at: index)
        storage?.deleteComponent(index: index)
    }
}
