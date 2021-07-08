//
//  OtherCategoryTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 08/07/2021.
//

import UIKit

class OtherCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductPriceLabel: UILabel!
    @IBOutlet weak var ProductNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
