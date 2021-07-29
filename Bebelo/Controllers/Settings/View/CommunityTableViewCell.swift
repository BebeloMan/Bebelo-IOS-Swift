//
//  CommunityTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ForwordImage: UIImageView!
    @IBOutlet weak var ivImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
