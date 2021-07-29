//
//  BebloView.swift
//  Bebelo
//
//  Created by Buzzware Tech on 21/01/2022.
//

import UIKit
import SwiftyGif
class BebloView: UIView {
    @IBOutlet weak var imgview:UIImageView!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        do {
            if let url = Bundle.main.url(forResource: "360 spin animation 20 fps head only", withExtension: "gif"){
                self.imgview.setGifFromURL(url)
            }
            
        } catch let error{
            print(error)
        }
    }
    

}
