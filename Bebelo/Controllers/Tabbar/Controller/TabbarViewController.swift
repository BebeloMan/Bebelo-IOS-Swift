//
//  TabbarViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 14/07/2021.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        if let items = self.tabBar.items {
            for item in items{
                let attributes = [NSAttributedString.Key.font:UIFont(name: "Roboto-Black", size: 10)]
                item.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
                item.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .selected)
            }
            tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.white, size: CGSize(width: tabBar.frame.width/CGFloat(items.count), height: tabBar.frame.height))
        }
    }
}
