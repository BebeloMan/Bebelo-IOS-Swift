//
//  LocationsTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 11/01/2022.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
