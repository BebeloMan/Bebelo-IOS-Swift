//
//  BarAnnotationView.swift
//  Bebelo
//
//  Created by Buzzware Tech on 21/09/2021.
//

import UIKit
import MapboxMaps
class viewsss:UIView{
    override func draw(_ rect: CGRect) {
        
    }
}
class BarAnnotationView: UIView {
    
    var imageView: UIImageView!
    var lblPrice: UILabel!

    required init(image: UIImage,title:String) {

        super.init(frame:.zero)
        let im = UIImageView(image: image)
        self.imageView = UIImageView(image: image)
        self.lblPrice = UILabel()
        //self.lblPrice.frame.origin = CGPoint(x: self.imageView.frame.origin.x, y: -3)
        //self.lblPrice.frame = self.imageView.frame.size
        self.lblPrice.textAlignment = .center
        self.lblPrice.text = title
        self.lblPrice.textColor = .black
        if title.count > 3{
            self.lblPrice.font = UIFont(name: Constant.cabinSFont, size: 10)
        }
        else if title.count > 4{
            self.lblPrice.font = UIFont(name: Constant.cabinSFont, size: 8)
        }
        else if title.count > 5{
            self.lblPrice.font = UIFont(name: Constant.cabinSFont, size: 6)
        }
        else{
            self.lblPrice.font = UIFont(name: Constant.cabinSFont, size: 13)
        }

//        self.lblPrice.adjustsFontSizeToFitWidth = true
//        self.lblPrice.minimumScaleFactor = 0.15
        self.addSubview(self.imageView)
        self.imageView.addSubview(self.lblPrice)
        self.lblPrice.frame = self.imageView.bounds
        self.lblPrice.frame.origin = CGPoint(x: self.imageView.bounds.origin.x, y: -3)
        self.frame = self.imageView.frame
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        // Use CALayer’s corner radius to turn this view into a circle.
//        layer.cornerRadius = bounds.width / 2
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.white.cgColor
    }
}
class BarAnnotationView1: UIView {
    
//    var imageView: UIImageView!
//    var lblPrice: UILabel!
//
//    required init(reuseIdentifier: String?, image: UIImage) {
//        super.init(reuseIdentifier: reuseIdentifier)
//
//        self.imageView = UIImageView(image: image)
//        self.addSubview(self.imageView)
//        self.frame = self.imageView.frame
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}
