//
//  AddDrinksTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 28/07/2021.
//

import UIKit

class AddDrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var DrinkImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var PriceField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
