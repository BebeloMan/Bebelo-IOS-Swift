//
//  PopupHelper.swift
//  TradeAir
//
//  Created by Adeel on 08/10/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import STPopup
class PopupHelper
{
    /// Show a popup using the STPopup framework [STPopup on Cocoapods](https://cocoapods.org/pods/STPopup)
    /// - parameters:
    ///   - storyBoard: the name of the storyboard the popup viewcontroller will be loaded from
    ///   - popupName: the name of the viewcontroller in the storyboard to load
    ///   - viewController: the viewcontroller the popup will be popped up from
    ///   - blurBackground: boolean to indicate if the background should be blurred
    /// - returns: -
    static let sharedInstance = PopupHelper() //<- Singleton Instance
    
    private init() { /* Additional instances cannot be created */ }
    static func alertWithField(title: String,message: String,qty: String,unit: String,part: String){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Quantity"
            textField.text = qty
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Unit"
            textField.text = unit
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Part"
            textField.text = part
            textField.placeHolderColor = UIColor().colorsFromAsset(name: .themeColor)
        }
        let saveAction = UIAlertAction.init(title: "Save", style: .default) { (alertAction) in
            
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        
    }
    static func alertWithOk(title: String,message: String,controler:UIViewController){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            controler.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(saveAction)
        controler.present(alertController, animated: true, completion: nil)
        
        
        
    }
    static func alertWithNetwork(title: String,message: String,controler:UIViewController){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            
        }
        let settinfAction = UIAlertAction.init(title: "Setting".localized(), style: .destructive) { (alertAction) in
            if let url = URL(string:"App-Prefs:root=WIFI") {
                if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                else{
                    if let url = URL(string:UIApplication.openSettingsURLString){
                        if UIApplication.shared.canOpenURL(url) {
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    
                }
            }
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(settinfAction)
        controler.present(alertController, animated: true, completion: nil)
        
        
        
    }
    class func showAnimating(_ isBeblo:Bool = true ,controler:UIViewController){
        if isBeblo{
            let view = Bundle.main.loadNibNamed("BebloView", owner: controler, options: nil)?.first as! BebloView
            view.frame = controler.view.bounds
            controler.view.addSubview(view)
        }
        else{
            controler.startAnimating(CGSize(width: controler.view.frame.width/2, height: controler.view.frame.width/4), message: "Loading...", type: .lineScale , fadeInAnimation: nil)
        }
        
        
    }
    class func stopAnimating(_ isBeblo:Bool = true,controler:UIViewController){
        if isBeblo{
            for view in controler.view.subviews{
                if view.isKind(of: BebloView.self){
                    view.removeFromSuperview()
                    break
                }
            }
            controler.stopAnimating()
        }
        else{
            controler.stopAnimating()
        }
        
        
    }
    class func showAlertControllerWithError(forErrorMessage:String?, forViewController:UIViewController) -> () {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: (forErrorMessage?.isEmpty == true) ? "Error occurred":forErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        DispatchQueue.main.async {
            forViewController.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertControllerWithErrorBack(forErrorMessage:String?, forViewController:UIViewController) -> () {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: (forErrorMessage?.isEmpty == true) ? "Error occurred":forErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: { (action) in
            forViewController.navigationController?.popViewController(animated: true)
        }))
        DispatchQueue.main.async {
            forViewController.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertControllerWithSucces(forErrorMessage:String?, forViewController:UIViewController) -> () {
        let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: (forErrorMessage?.isEmpty == true) ? "Error occurred":forErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        DispatchQueue.main.async {
            forViewController.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertControllerWithSuccessBack(forErrorMessage:String?, forViewController:UIViewController) -> () {
        let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: (forErrorMessage?.isEmpty == true) ? "Error occurred":forErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: { (action) in
            forViewController.navigationController?.popViewController(animated: true)
        }))
        DispatchQueue.main.async {
            forViewController.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertControllerWithSuccessBacktoRoot(forErrorMessage:String?, forViewController:UIViewController) -> () {
        let alert = UIAlertController(title: NSLocalizedString("Success", comment: ""), message: (forErrorMessage?.isEmpty == true) ? "Error occurred":forErrorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: { (action) in
            forViewController.navigationController?.popToRootViewController(animated: true)
        }))
        DispatchQueue.main.async {
            forViewController.present(alert, animated: true, completion: nil)
        }
    }
    static func alertWithAppSetting(title: String,message: String,controler:UIViewController){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            self.gotoSetting()
        }
        let settingAction = UIAlertAction.init(title: "Settings".localized(), style: .destructive) { (alertAction) in
            
        }
        alertController.addAction(okAction)
        alertController.addAction(settingAction)
        controler.present(alertController, animated: true, completion: nil)
        
        
    
    }
    static func gotoSetting(){
        if let appSettings = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
          if UIApplication.shared.canOpenURL(appSettings) {
            UIApplication.shared.open(appSettings)
          }
        }
    }
    static func changeRootView(storyboardName:String,ViewControllerId:String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerId) as! UITabBarController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    static func changeRootViewController(storyboardName:String,ViewControllerId:String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerId)
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    static func alertTimingViewController(_ userServiceData:Bool? = nil,controler:UIViewController){

        //let navcontroler = controler.storyboard?.instantiateViewController(identifier: "NavBookingViewController") as! UINavigationController
        let control = controler.storyboard?.instantiateViewController(identifier: "ShowTimingViewController") as! ShowTimingViewController
        control.delegate = controler
        //control.userData = userServiceData
        //navcontroler.addChild(control)
        let popupController = STPopupController(rootViewController: control)

        var size = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.5)
        if UIDevice.current.userInterfaceIdiom == .phone{
            size.height = controler.view.frame.height/1.5
            
        }
        else{
            size.height = controler.view.frame.height/0.5
        }
        control.contentSizeInPopup = size
        //popupController.topViewController?.contentSizeInPopup = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.1)
        popupController.navigationBarHidden = true
        popupController.topViewController?.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
        popupController.containerView.backgroundColor = .clear
        control.popup = popupController
        popupController.present(in: controler)
        
    }
    static func alertDeleteBarViewController(_ userServiceData:Bool? = nil,controler:UIViewController){

        //let navcontroler = controler.storyboard?.instantiateViewController(identifier: "NavBookingViewController") as! UINavigationController
        let control = controler.storyboard?.instantiateViewController(identifier: "DeleteBarViewController") as! DeleteBarViewController
        control.delegate = controler
        //control.userData = userServiceData
        //navcontroler.addChild(control)
        let popupController = STPopupController(rootViewController: control)

        var size = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.5)
        if UIDevice.current.userInterfaceIdiom == .phone{
            size.height = controler.view.frame.height/1.5
            
        }
        else{
            size.height = controler.view.frame.height/0.5
        }
        control.contentSizeInPopup = size
        //popupController.topViewController?.contentSizeInPopup = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.1)
        popupController.navigationBarHidden = true
        popupController.topViewController?.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
        popupController.containerView.backgroundColor = .clear
        control.popup = popupController
        popupController.present(in: controler)
        
    }
    static func alertContactusViewController(_ userServiceData:Bool? = nil,controler:UIViewController){

        //let navcontroler = controler.storyboard?.instantiateViewController(identifier: "NavBookingViewController") as! UINavigationController
        let control = controler.storyboard?.instantiateViewController(identifier: "ContactUsViewController") as! ContactUsViewController
        control.delegate = controler
        //control.userData = userServiceData
        //navcontroler.addChild(control)
        let popupController = STPopupController(rootViewController: control)

        var size = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.5)
        if UIDevice.current.userInterfaceIdiom == .phone{
            size.height = controler.view.frame.height/1.5
            
        }
        else{
            size.height = controler.view.frame.height/0.5
        }
        control.contentSizeInPopup = size
        //popupController.topViewController?.contentSizeInPopup = CGSize(width: controler.view.frame.width/1.1, height: controler.view.frame.height/1.1)
        popupController.navigationBarHidden = true
        popupController.topViewController?.view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
        popupController.containerView.backgroundColor = .clear
        control.popup = popupController
        popupController.present(in: controler)
        
    }
}

