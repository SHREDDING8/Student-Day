//
//  CellToDo.swift
//  Student Day
//
//  Created by SHREDDING on 01.03.2023.
//

import Foundation
import UIKit


class CellToDo{
    
    private var title:String
    private var description:String?
    private var color:UIColor = UIColor(named: "gray")!
    
    init(title: String, description: String? = nil, color: UIColor) {
        self.title = title
        self.description = description
        self.color = color
    }
    
}
