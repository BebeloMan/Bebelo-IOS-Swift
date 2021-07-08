//
//  BarInfoImageTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit

class BarInfoImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CaptureImage: UIImageView!
    @IBOutlet weak var EditImageBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
