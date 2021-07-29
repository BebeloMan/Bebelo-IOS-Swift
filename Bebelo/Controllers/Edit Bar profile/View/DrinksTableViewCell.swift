//
//  DrinksTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var DrinkImage: UIImageView!
    @IBOutlet weak var DrinkTitle: UILabel!
    @IBOutlet weak var DrinkPrice: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
