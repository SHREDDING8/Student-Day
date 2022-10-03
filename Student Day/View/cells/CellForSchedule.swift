//
//  CellForSchedule.swift
//  Student Day
//
//  Created by SHREDDING on 27.09.2022.
//

import UIKit

class CellForSchedule: UITableViewCell {
    
    @IBOutlet weak var nameOfCourse: UILabel!
    
    @IBOutlet weak var nameOfProf: UILabel!
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var place: UILabel!
    
    @IBOutlet weak var timeStartLabel: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
