//
//  AppDelegate.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController
import CoreLocation
import FirebaseCore
import FirebaseMessaging
import FirebaseInstallations
import FirebaseAuth
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var deviceTokenForPushN = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        
        //registerForPushNotifications()
        FirebaseApp.configure()
        self.setLang(lang: .es)
        IQKeyboardManager.shared.enable = true
        checkUserAlreadyLogin()
        if !UserDefaults.standard.bool(forKey: "isFirstTime"){
            UserDefaults.standard.set(true, forKey: "isFirstTime")
            LangHelper.setLangauge(lang: .en)
        }
        let token = Messaging.messaging().fcmToken
        // print ("the token is " , token!)
        print("FCM token: \(token ?? "")")
        deviceTokenForPushN = (" \(token ?? "")")
        print("FCM deviceTokenForPushN: \(deviceTokenForPushN )")
        UserDefaults.standard.set(deviceTokenForPushN, forKey: Constant.token_id)
        UserDefaults.standard.synchronize()
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().delegate = self
        registerForPushNotifications()
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        Messaging.messaging().apnsToken = deviceToken
        print ("ashdgjasjda" ,  deviceToken )
        print("Device Token: \(token)")
    }
    func application(_ application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)) , name: .MessagingRegistrationTokenRefreshed, object: nil)
            }
        }
    }
    @objc func refreshToken(notification : NSNotification) {
        Installations.installations().installationID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result)")
            }
        }
        
    }
    
}
extension AppDelegate:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            UserDefaults.standard.set(false, forKey: Constant.locationAccessKey)
        case .notDetermined:
            print("Location status not determined.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            manager.startUpdatingLocation()
        case .authorizedAlways:
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("Location status is OK.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            manager.startUpdatingLocation()
        @unknown default:
            print("Unknown case found")
        }
    }
}
extension AppDelegate{
    private func setLang(lang: Languages) {
        LangHelper.setLangauge(lang: lang)
    }
    func checkUserAlreadyLogin() {
        var storyboard :UIStoryboard!

        storyboard = UIStoryboard(name: "Main", bundle: nil)

        //try! Auth.auth().signOut()
        if UserDefaults.standard.value(forKey: Constant.isFirstTime) != nil{
            if !FirebaseData.getCurrentUserId().0.isEmpty{
                let controller = storyboard.instantiateViewController(identifier: "LGSideMenuController") as! LGSideMenuController
                self.window?.rootViewController = controller
            }
            else{
                let controller = storyboard.instantiateViewController(identifier: "WellcomeViewController")
                self.window?.rootViewController = controller
            }
            
        }
        else{
            UserDefaults.standard.set(true, forKey: Constant.isFirstTime)
            let controller = storyboard.instantiateViewController(identifier: "WellcomeViewController")
            self.window?.rootViewController = controller
        }
        

        self.window?.makeKeyAndVisible()

    }
    
}
extension AppDelegate:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if notification.request.identifier == "Local Notification Order" {
            print("Handling notifications with the Local Notification Identifier")
            center.removeDeliveredNotifications(withIdentifiers: [notification.request.identifier])
            center.removePendingNotificationRequests(withIdentifiers: [notification.request.identifier])
            
            
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let userInfo = notification.request.content.userInfo
        
        print ("the user info is " , userInfo )
        
        //            let str = String(describing: userInfo)
        //
        //            let arr = str.components(separatedBy: ",")
        //
        //        let arr2 = arr.filter { (val) -> Bool in
        //            return val.contains("status")
        //        }
        //        if arr2.count > 0{
        //            let arr3 = arr2[0].components(separatedBy: ":")
        //            print("the arr2 is" , arr3)
        //            let type = arr3.last
        //
        //            print("the type is" , type!)
        //
        //            let typ = type?.replacingOccurrences(of: " ", with: "")
        //            if typ == "1"{
        //                self.userNotify()
        //                //self.timer =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(userNotify), userInfo: nil, repeats: true)
        //
        //            }
        //        }
        
        
        
        
        
        
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification Order" {
            print("Handling notifications with the Local Notification Identifier")
            center.removeDeliveredNotifications(withIdentifiers: [response.notification.request.identifier])
            UIApplication.shared.applicationIconBadgeNumber = 0
            completionHandler()
            
        }
        
    }
    
//    @objc func userNotify(){
//        let notificationCenter = UNUserNotificationCenter.current()
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        notificationCenter.requestAuthorization(options: options) {
//            (didAllow, error) in
//            if !didAllow {
//                print("User has declined notifications")
//                return
//            }
//        }
//        notificationCenter.getNotificationSettings { (settings) in
//            if settings.authorizationStatus != .authorized {
//                // Notifications not allowed
//                return
//            }
//        }
//        let content = UNMutableNotificationContent() // Содержимое уведомления
//        
//        content.title = "TastyBox"
//        content.body = "Your Order Ready please collect it now"
//        content.sound = UNNotificationSound.default
//        content.badge = 1
//        
//        
//        let date = Date(timeIntervalSinceNow: 1800)
//        let triggerHourly = Calendar.current.dateComponents([.second], from: date)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerHourly, repeats: true)
//        
//        let identifier = "Local Notification Order"
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        
//        notificationCenter.add(request) { (error) in
//            if let error = error {
//                print("Error \(error.localizedDescription)")
//            }
//        }
//        notificationCenter.delegate = self
//        
//    }
}
