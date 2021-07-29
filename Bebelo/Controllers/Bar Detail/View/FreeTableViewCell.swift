//
//  FreeTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 22/01/2022.
//

import UIKit

class FreeTableViewCell: UITableViewCell {

    @IBOutlet weak var SideImage: UIImageView!
    @IBOutlet weak var Title: UITextView!
    @IBOutlet weak var DeailLabel: UILabel!
    @IBOutlet weak var TarraceAsegment: UISwitch!
    @IBOutlet weak var BackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
