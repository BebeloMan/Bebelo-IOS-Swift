//
//  CustomTabBar.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit

class CustomTabBar: UITabBar {
    @IBInspectable var height: CGFloat = 0.0

        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            if height > 0.0 {
                sizeThatFits.height = height
            }
            return sizeThatFits
        }
}
