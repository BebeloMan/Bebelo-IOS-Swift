//
//  MapTableViewCell.swift
//  Bebelo
//
//  Created by Buzzware Tech on 28/07/2021.
//

import UIKit
import MapboxMaps
class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var Mapbox: MapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
