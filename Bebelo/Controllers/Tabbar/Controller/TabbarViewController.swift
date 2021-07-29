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
        if CommonHelper.getCachedUserData() != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let profileVC = storyboard.instantiateViewController(identifier: "ProfileVC") as UINavigationController
            self.viewControllers?.append(profileVC)
            if let profileTabItem = self.tabBar.items?[2] {
                profileTabItem.title = "Profile" // tabbar titlee
                profileTabItem.image=UIImage(named: "Group 210")?.withRenderingMode(.alwaysOriginal) // deselect image
                profileTabItem.selectedImage = UIImage(named: "Profile")// select image
                profileTabItem.badgeColor = UIColor().colorsFromAsset(name: .themeColor)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.tabBar.shadowImage = UIImage()
        self.tabBar.unselectedItemTintColor = .black
        
        if let items = self.tabBar.items {
            for item in items{
                let attributes = [
                    NSAttributedString.Key.font:UIFont (
                        name: "Cabin-Bold",
                        size: 12
                    ),NSAttributedString.Key.foregroundColor:UIColor(named: "tabBtnColor")
                ]
                let attributes1 = [
                    NSAttributedString.Key.font:UIFont (
                        name: "Cabin-Bold",
                        size: 12
                    ),NSAttributedString.Key.foregroundColor:UIColor.black
                ]
                
                item.setTitleTextAttributes(attributes1 as [NSAttributedString.Key : Any], for: .normal)
                item.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .selected)
                
            }
            
//            tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.white, size: CGSize(width: tabBar.frame.width/CGFloat(items.count), height: tabBar.frame.height))
        }
    }
}
