//
//  ToDoTableViewCell.swift
//  Student Day
//
//  Created by SHREDDING on 01.03.2023.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {


    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
