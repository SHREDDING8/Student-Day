//
//  section.swift
//  Student Day
//
//  Created by SHREDDING on 01.03.2023.
//

import Foundation
import UIKit

class SectionToDo{
    
    private var title:String
    private var cells:[CellToDo]?
    
    
    public func getTitle() ->String{
        return self.title
    }
    public func getCells() -> [CellToDo]?{
        return self.cells
    }
    
    init(title: String, cells: [CellToDo]? = nil) {
        self.title = title
        self.cells = cells
    }
}
