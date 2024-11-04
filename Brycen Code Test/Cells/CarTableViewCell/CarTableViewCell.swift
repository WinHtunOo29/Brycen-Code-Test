//
//  CarTableViewCell.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carTypeLb: UILabel!
    @IBOutlet weak var carNumberLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
