//
//  ContactInfoTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit

class ContactInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var FieldTF: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
