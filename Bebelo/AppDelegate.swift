//
//  AppDelegate.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.checkUserAlreadyLogin()
        
        return true
    }
    
    
    
}

extension AppDelegate{
    func checkUserAlreadyLogin() {
        var storyboard :UIStoryboard!
        //if UIDevice.current.userInterfaceIdiom == .phone{
            storyboard = UIStoryboard(name: "Main", bundle: nil)
//        }
//        else{
//            storyboard = UIStoryboard(name: "Ipad", bundle: nil)
//        }
//        if (CommonHelper.getCachedUserData()?.id != nil){
//            let controller = storyboard.instantiateViewController(identifier: "LGSideMenuController") as! UIViewController
//            self.window?.rootViewController = controller
//        }else{
            let controller = storyboard.instantiateViewController(identifier: "WellcomeViewController") as! UIViewController
            self.window?.rootViewController = controller
        //}
        self.window?.makeKeyAndVisible()
    }
}
