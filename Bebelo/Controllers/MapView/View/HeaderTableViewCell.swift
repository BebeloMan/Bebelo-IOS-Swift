//
//  HeaderTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 02/11/2021.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var btnMore:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
