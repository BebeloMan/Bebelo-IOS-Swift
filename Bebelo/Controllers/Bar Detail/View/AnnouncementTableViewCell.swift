//
//  AnnouncementTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 08/07/2021.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {

    @IBOutlet weak var SideImage: UIImageView!
    @IBOutlet weak var Title: UITextView!
    @IBOutlet weak var DeailLabel: UILabel!
    @IBOutlet weak var AnunciaBtn: UIButton!
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
