//
//  BarDetailTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit

class BarDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblOpen:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var timingStack:UIStackView!
    @IBOutlet weak var btnInfo:UIButton!
    @IBOutlet weak var lblAnnounce:UILabel!
    @IBOutlet weak var ivAnnounce:UIImageView!
    @IBOutlet weak var lblTable:UILabel!
    @IBOutlet weak var ivTable:UIImageView!
    @IBOutlet weak var vImage:UIImageView!
    @IBOutlet weak var ivBaja:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
