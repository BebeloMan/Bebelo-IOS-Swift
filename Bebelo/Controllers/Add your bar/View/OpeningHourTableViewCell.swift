//
//  OpeningHourTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit

class OpeningHourTableViewCell: UITableViewCell {

    @IBOutlet weak var WeekNameLabel: UILabel!
    @IBOutlet weak var AddBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
