//
//  AddBarTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit

class AddBarTableViewCell: UITableViewCell {

    @IBOutlet weak var ForwordImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var SideImage: UIImageView!
    @IBOutlet weak var AddYourBarBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var AlreadyEnterdLabel: UILabel!
    @IBOutlet weak var ForwordArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
