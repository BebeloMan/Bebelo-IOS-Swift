//
//  LocationTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var OpenAppBtn: UIButton!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.OpenAppBtn.setTitle("Allow location".localized(), for: .normal)
        //self.title.text = self.title.text?.localized()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
