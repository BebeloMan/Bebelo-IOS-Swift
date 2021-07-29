//
//  SupplimentTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/09/2021.
//

import UIKit

class SupplimentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnNoCheck:UIButton!
    @IBOutlet weak var btnYesCheck:UIButton!
    //@IBOutlet weak var tfYes:UITextField!
    //@IBOutlet weak var btnDropdown:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
