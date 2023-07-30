//
//  NewClassWithSubTitleTableViewCell.swift
//  Student Day
//
//  Created by SHREDDING on 29.07.2023.
//

import UIKit

class NewClassWithSubTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
