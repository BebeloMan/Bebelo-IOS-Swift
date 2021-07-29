//
//  CommonHelper.swift
//  TradeAir
//
//  Created by Adeel on 08/10/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit
import SwiftyJSON
class CommonHelper
{
    static let sharedInstance = CommonHelper() //<- Singleton Instance
    
    private init() { /* Additional instances cannot be created */ }
    
    class func round(_ val: Double, to decimals: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals
        formatter.roundingMode = .up
        let ret = formatter.string(from: val as NSNumber)
        
        return ret
    }
    
    
    
    class func setLeftPadding(_ txt: UITextField?)
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txt?.leftView = paddingView
        txt?.leftViewMode = .always
        txt?.setNeedsLayout()
        txt?.setNeedsDisplay()
    }
    
    class func getLocale() -> String? {
        return NSLocale.preferredLanguages[0]
    }
    
    class func showAllFontsFamiliesNames() -> Void
    {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    class func getCSVData(_ completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        guard let userfilepath = Bundle.main.path(forResource: "user", ofType: "csv")
                    else {
                        completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
            
                }
        guard let drinkfilepath = Bundle.main.path(forResource: "drink", ofType: "csv")
                    else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
                }
        guard let barhasfilepath = Bundle.main.path(forResource: "barhas", ofType: "csv")
                    else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
                }
        guard let weekfilepath = Bundle.main.path(forResource: "week", ofType: "csv")
                    else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
                }
        
        do {
            let usercontent = try String(contentsOfFile: userfilepath,encoding: .utf8)
            let userdata = usercontent.components(separatedBy: "\n")
            
            let drinkcontent = try String(contentsOfFile: drinkfilepath,encoding: .utf8)
            let drinkdata = drinkcontent.components(separatedBy: "\n")
            
            let barhascontent = try String(contentsOfFile: barhasfilepath,encoding: .utf8)
            let barhasdata = barhascontent.components(separatedBy: "\n")
            
            let weekcontent = try String(contentsOfFile: weekfilepath,encoding: .utf8)
            let weekdata = weekcontent.components(separatedBy: "\n")
            
            var array = [UserModel]()
            var mainid = ""
            if userdata.count > 0{
                for (j,dat) in userdata.enumerated(){
                    if j != 0{
                        let val = dat.components(separatedBy: ",")
                        var user = UserModel.empty
                        user.isAdded = false
                        if val.count > 0{
                            for (i,arr) in val.enumerated(){
                                switch i{
                                case 0:
                                    mainid = arr
                                    user.uuid = Int64(mainid) ?? 0
                                case 1:
                                    user.displayPrice = arr.replacingOccurrences(of: ";", with: ",")
                                case 2:
                                    user.cname = arr.replacingOccurrences(of: ";", with: ",")
                                case 3:
                                    user.cemail = arr.replacingOccurrences(of: ";", with: ",")
                                case 5:
                                    user.cphone = arr.replacingOccurrences(of: ";", with: ",")
                                    
                                    
                                case 6:
                                    user.bname = arr.replacingOccurrences(of: ";", with: ",")
                                    
                                case 7:
                                    user.baddress = arr.replacingOccurrences(of: ";", with: ",")
                                    
                                case 8:
                                    user.blat = Double(arr) ?? 0
                                    
                                case 9:
                                    user.blng = Double(arr) ?? 0
                                    
                                case 10:
                                    user.image = arr.replacingOccurrences(of: ";", with: ",")
                                    
                                case 12:
                                    user.isSupliment = Bool(arr) ?? false
                                case 13:
                                    var dicArray = [OnlyShowModel]()
                                    if barhasdata.count > 0{
                                        for (j,dat) in barhasdata.enumerated(){
                                            if j != 0{
                                                let val = dat.components(separatedBy: ",")
                                                var dic = OnlyShowModel(title: "", isSelected: false)
                                                var uid = ""
                                                if val.count > 0{
                                                    
                                                    for (i,arr) in val.enumerated(){
                                                        switch i{
                                                        case 0:
                                                            uid = arr
                                                        case 1:
                                                            if uid == mainid{
                                                                if arr == "TRUE"{
                                                                    dic.isSelected = true
                                                                }
                                                                else{
                                                                    dic.isSelected = false
                                                                }
                                                                
                                                            }
                                                        case 2:
                                                            if uid == mainid{
                                                                let ev = arr.replacingOccurrences(of: "\r", with: "")
                                                                dic.title = ev
                                                            }
                                                        default:
                                                            continue
                                                        }
                                                    }
                                                    if uid == mainid{
                                                        dicArray.append(dic)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                    user.barHas = dicArray
                                case 14:
                                    var dicArray = [WeekDayModel]()
                                    if weekdata.count > 0{
                                        for (j,dat) in weekdata.enumerated(){
                                            if j != 0{
                                                let val = dat.components(separatedBy: ",")
                                                var dic = WeekDayModel()
                                                var uid = ""
                                                if val.count > 0{
                                                    
                                                    for (i,arr) in val.enumerated(){
                                                        switch i{
                                                        case 0:
                                                            uid = arr
                                                        case 1:
                                                            if uid == mainid{
                                                                dic.weekDay = weekfullDay(rawValue: arr)
                                                            }
                                                        case 2:
                                                            if uid == mainid{
                                                                dic.name = arr
                                                            }
                                                        case 3:
                                                            if uid == mainid{
                                                                dic.svalue = Int64(arr)
                                                            }
                                                        case 4:
                                                            if uid == mainid{
                                                                let ev = arr.replacingOccurrences(of: "\r", with: "")
                                                                dic.evalue = Int64(ev)
                                                            }
                                                        default:
                                                            continue
                                                        }
                                                    }
                                                    if uid == mainid{
                                                        dicArray.append(dic)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                    user.barWeekDay = dicArray
                                case 15:
                                    var dicArray = [DrinkPricesModel]()
                                    if drinkdata.count > 0{
                                        for (j,dat) in drinkdata.enumerated(){
                                            if j != 0{
                                                let val = dat.components(separatedBy: ",")
                                                var dic = DrinkPricesModel()
                                                var uid = ""
                                                if val.count > 0{
                                                    
                                                    for (i,arr) in val.enumerated(){
                                                        switch i{
                                                        case 0:
                                                            uid = arr
                                                        case 1:
                                                            if uid == mainid{
                                                                dic.drinkPrice = arr
                                                            }
                                                        case 2:
                                                            if uid == mainid{
                                                                dic.drinkImage = arr
                                                            }
                                                        case 3:
                                                            if uid == mainid{
                                                                dic.drinkName = DrinkNameKeys(rawValue: arr) ?? .Doble
                                                            }
                                                        default:
                                                            continue
                                                        }
                                                    }
                                                    if uid == mainid{
                                                        dicArray.append(dic)
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                    user.barBottle = dicArray
                                default:
                                    continue
                                }
                            }
                            user.userDate = Date().toMillisInt64()
                            user.deviceType = "IOS"
                            user.isFreeTable = false
                            user.isAnnounce = false
                            array.append(user)
                        }
                    }
                    
                }
                
            }
            completion(nil,array)
        }
        catch let error{
            completion(error,nil)
        }
    }
    class func getCSVUserData(_ completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        guard let userfilepath = Bundle.main.path(forResource: "user", ofType: "csv")
        else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
            
        }
        
        do {
            let usercontent = try String(contentsOfFile: userfilepath,encoding: .utf8)
            let userdata = usercontent.components(separatedBy: "\n")
            
            var array = [UserModel]()
            var mainid = ""
            if userdata.count > 0{
                for (j,dat) in userdata.enumerated(){
                    if j != 0{
                        let val = dat.components(separatedBy: ",")
                        var user = UserModel.empty
                        user.isAdded = false
                        if val.count > 0{
                            for (i,arr) in val.enumerated(){
                                switch i{
                                case 0:
                                    mainid = arr
                                    user.uuid = Int64(arr) ?? 0
                                case 1:
                                    user.displayPrice = arr
                                    
                                case 2:
                                    user.cname = arr.replacingOccurrences(of: ";", with: ",")
                                case 3:
                                    user.cemail = arr.replacingOccurrences(of: ";", with: ",")
                                case 5:
                                    user.cphone = arr.replacingOccurrences(of: ";", with: ",")
                                case 6:
                                    user.bname = arr.replacingOccurrences(of: ";", with: ",")
                                case 7:
                                    user.baddress = arr.replacingOccurrences(of: ";", with: ",")
                                case 8:
                                    user.blat = Double(arr) ?? 0
                                case 9:
                                    user.blng = Double(arr) ?? 0
                                    
                                case 10:
                                    user.image = arr.replacingOccurrences(of: ";", with: ",")
                                case 11:
                                    user.isSupliment = Bool(arr) ?? false
                                default:
                                    continue
                                }
                            }
                            user.userDate = Date().toMillisInt64()
                            user.deviceType = "IOS"
                            user.isFreeTable = false
                            user.isAnnounce = false
                            array.append(user)
                        }
                    }
                    
                }
                
            }
            completion(nil,array)
        }
        catch let error{
            completion(error,nil)
        }
    }
    class func getCSVDrinkData(_ completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        
        guard let drinkfilepath = Bundle.main.path(forResource: "drink", ofType: "csv")
                    else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
                }
        
        do {
            
            let drinkcontent = try String(contentsOfFile: drinkfilepath,encoding: .utf8)
            let drinkdata = drinkcontent.components(separatedBy: "\n")
            
            var array = [UserModel]()
            var mainid = ""
            var user = UserModel.empty
            var dicArray = [DrinkPricesModel]()
            if drinkdata.count > 0{
                for (j,dat) in drinkdata.enumerated(){
                    if j != 0{
                        //mainid = "\(j - 1)"
                        var uid = ""
                        
                        let val = dat.components(separatedBy: ",")
                        var dic = DrinkPricesModel()
                        
                        if val.count > 0{
                            
                            for (i,arr) in val.enumerated(){
                                switch i{
                                case 0:
                                    uid = arr
                                    if mainid != arr{
                                        if dicArray.count > 0{
                                            user.barBottle = dicArray
                                            user.isAdded = false
                                            user.uuid = Int64(mainid) ?? 0
                                            array.append(user)
                                        }
                                        mainid = arr
                                        
                                        user = UserModel.empty
                                        dicArray = [DrinkPricesModel]()
                                    }
                                case 1:
                                    if uid == mainid{
                                        dic.drinkPrice = arr
                                    }
                                case 2:
                                    if uid == mainid{
                                        dic.drinkImage = arr
                                    }
                                case 3:
                                    if uid == mainid{
                                        dic.drinkName = DrinkNameKeys(rawValue: arr) ?? .Doble
                                    }
                                default:
                                    continue
                                }
                            }
                            if uid == mainid{
                                dicArray.append(dic)
                            }
                            
                        }
                        
                        
                    }
                }
                
            }
            completion(nil,array)
        }
        catch let error{
            completion(error,nil)
        }
    }
    class func getCSVbarData(_ completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        
        guard let barhasfilepath = Bundle.main.path(forResource: "barhas", ofType: "csv")
                    else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
                }
        
        do {
            
            let barhascontent = try String(contentsOfFile: barhasfilepath,encoding: .utf8)
            let barhasdata = barhascontent.components(separatedBy: "\n")
            
            var array = [UserModel]()
            var mainid = ""
            var user = UserModel.empty
            var dicArray = [OnlyShowModel]()
            if barhasdata.count > 0{
                for (j,dat) in barhasdata.enumerated(){
                    if j != 0{
                        //mainid = "\(j - 1)"
                        var uid = ""
                        
                        let val = dat.components(separatedBy: ",")
                        var dic = OnlyShowModel()
                        
                        if val.count > 0{
                            for (i,arr) in val.enumerated(){
                                switch i{
                                case 0:
                                    uid = arr
                                    if mainid != arr{
                                        if dicArray.count > 0{
                                            user.barHas = dicArray
                                            user.isAdded = false
                                            user.uuid = Int64(mainid) ?? 0
                                            array.append(user)
                                        }
                                        mainid = arr
                                        
                                        user = UserModel.empty
                                        dicArray = [OnlyShowModel]()
                                    }
                                case 1:
                                    if uid == mainid{
                                        if arr == "TRUE"{
                                            dic.isSelected = true
                                        }
                                        else{
                                            dic.isSelected = false
                                        }
                                        
                                    }
                                case 2:
                                    if uid == mainid{
                                        let ev = arr.replacingOccurrences(of: "\r", with: "")
                                        dic.title = ev
                                    }
                                default:
                                    continue
                                }
                            }
                            if uid == mainid{
                                dicArray.append(dic)
                            }
                            
                        }
                        
                        
                    }
                }
                
            }
            completion(nil,array)
        }
        catch let error{
            completion(error,nil)
        }
    }
    class func getCSVweekData(_ completion:@escaping (_ error:Error?, _ userData: [UserModel]?) -> ()) {
        
        guard let weekfilepath = Bundle.main.path(forResource: "week", ofType: "csv")
                    else {
            completion(NSError(domain: "No file found", code: 113, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("No Data", comment: "")]),nil)
            return
                }
        
        do {
            
            let weekcontent = try String(contentsOfFile: weekfilepath,encoding: .utf8)
            let weekdata = weekcontent.components(separatedBy: "\n")
            
            var array = [UserModel]()
            var mainid = ""
            var user = UserModel.empty
            var dicArray = [WeekDayModel]()
            if weekdata.count > 0{
                for (j,dat) in weekdata.enumerated(){
                    if j != 0{
                        //mainid = "\(j - 1)"
                        var uid = ""
                        
                        let val = dat.components(separatedBy: ",")
                        var dic = WeekDayModel()
                        
                        if val.count > 0{
                            for (i,arr) in val.enumerated(){
                                switch i{
                                case 0:
                                    uid = arr
                                    if mainid != arr{
                                        if dicArray.count > 0{
                                            user.barWeekDay = dicArray
                                            user.isAdded = false
                                            user.uuid = Int64(mainid) ?? 0
                                            array.append(user)
                                        }
                                        mainid = arr
                                        
                                        user = UserModel.empty
                                        dicArray = [WeekDayModel]()
                                    }
                                case 1:
                                    if uid == mainid{
                                        dic.weekDay = weekfullDay(rawValue: arr)
                                    }
                                case 2:
                                    if uid == mainid{
                                        dic.name = arr
                                    }
                                case 3:
                                    if uid == mainid{
                                        dic.svalue = Int64(arr)
                                    }
                                case 4:
                                    if uid == mainid{
                                        let ev = arr.replacingOccurrences(of: "\r", with: "")
                                        dic.evalue = Int64(ev)
                                    }
                                default:
                                    continue
                                }
                            }
                            if uid == mainid{
                                dicArray.append(dic)
                            }
                            
                        }
                        
                        
                    }
                }
                
            }
            completion(nil,array)
        }
        catch let error{
            completion(error,nil)
        }
    }
    class func getLocalizedImage(_ name: String?) -> UIImage? {
        return UIImage(named: "\(URL(fileURLWithPath: name ?? "").deletingPathExtension().absoluteString)_\(CommonHelper.getLocale() ?? "")")
    }
    class func saveCachedUserData(_ userData:UserModelW){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.login_key)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func saveCachedAnnounceData(_ userData:AnnounceModelW){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.announce_key)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func saveCachedFreeTableData(_ userData:FreeTableModelW){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.freetable_key)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func saveCachedUserLocData(_ userData:LocationModel){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.location)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func saveCachedMapLocData(_ userData:LocationModel){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.maplocation)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func saveOnlyShowData(_ userData:[OnlyShowModelW]){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.onlyshow_key)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func saveOnlyShowData1(_ userData:[OnlyShowModelW]){
        let userDefaults = UserDefaults.standard
        do {
            
            try userDefaults.setObject(userData, forKey: Constant.onlyshow_key1)
            userDefaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    class func getCachedUserData() -> UserModelW? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.login_key, castTo: UserModelW.self)
            print(user.id ?? "0")
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func getCachedAnnounceData() -> AnnounceModelW? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.announce_key, castTo: AnnounceModelW.self)
            if let data = user.data{
                if let bytes = Data(base64Encoded: data){
                    print(String(data: bytes, encoding: .utf8) ?? "0")
                }
            }
            
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func getCachedFreeTableData() -> FreeTableModelW? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.freetable_key, castTo: FreeTableModelW.self)
            print(user.freeTable ?? "0")
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func getOnlyShowData() -> [OnlyShowModelW]? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.onlyshow_key, castTo: [OnlyShowModelW].self)
            print(user.first?.title ?? "0")
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func getOnlyShowData1() -> [OnlyShowModelW]? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.onlyshow_key1, castTo: [OnlyShowModelW].self)
            print(user.first?.title ?? "0")
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func getCachedUserLocData() -> LocationModel? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.location, castTo: LocationModel.self)
            print(user.address_lat ?? "0")
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func getCachedMapLocData() -> LocationModel? {
        let userDefaults = UserDefaults.standard
        do {
            let user = try userDefaults.getObject(forKey: Constant.maplocation, castTo: LocationModel.self)
            print(user.address_lat ?? "0")
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    class func removeCachedUserData() {
        let userDefaults = UserDefaults.standard
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        userDefaults.synchronize()
    }
    
    // MARK: - Activity Indicator Inside Button
    func showActivityIndicator(_ activityIndicatorForButton: UIActivityIndicatorView?, inside buttonObj: UIButton?) {
        DispatchQueue.main.async(execute: {
            if (buttonObj?.frame.size.width ?? 0.0) <= 133.0 {
                buttonObj?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
            }
            let halfButtonHeight: CGFloat = (buttonObj?.bounds.size.height ?? 0.0) / 2
            let buttonWidth: CGFloat? = buttonObj?.bounds.size.width
            activityIndicatorForButton?.center = CGPoint(x: (buttonWidth ?? 0.0) - halfButtonHeight, y: halfButtonHeight)
            if let aButton = activityIndicatorForButton {
                buttonObj?.addSubview(aButton)
            }
            activityIndicatorForButton?.hidesWhenStopped = true
            activityIndicatorForButton?.startAnimating()
            buttonObj?.isUserInteractionEnabled = false
            /// Disable Other Controls
            //////////////////////////////////////////////////////////////////////
        })
    }
    
    func hideActivityIndicator(_ activityIndicatorForButton: UIActivityIndicatorView?, inside buttonObj: UIButton?) {
        if activityIndicatorForButton != nil {
            DispatchQueue.main.async(execute: {
                if (buttonObj?.frame.size.width ?? 0.0) <= 133.0 {
                    buttonObj?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                activityIndicatorForButton?.removeFromSuperview()
                activityIndicatorForButton?.stopAnimating()
                buttonObj?.isUserInteractionEnabled = true
                /// Disable Other Controls
                //////////////////////////////////////////////////////////////////////
            })
        }
    }
    
    
    // MARK: - Country Code for Current Device
    func getCountryCodeForCurrentDevice() -> String? {
        let currentLocale = NSLocale.current as NSLocale // get the current locale.
        let countryCode = currentLocale.object(forKey: .countryCode) as? String
        return countryCode
    }
    
    // MARK: - Images
    func image(with color: UIColor?, andSize imageSize: CGSize) -> UIImage? {
        let imageSizeRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        UIGraphicsBeginImageContext(imageSizeRect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor((color?.cgColor)!)
        context?.fill(imageSizeRect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - Screen Size
    var appScreenRect: CGRect {
        let appWindowRect = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        return appWindowRect
    }
    func getDirectoryPath(isImage:Bool = false) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var documentsDirectory = paths[0] as String
        if isImage{
            
            documentsDirectory = (paths[0] as NSString).appendingPathComponent("Images") as String
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: documentsDirectory){
                return documentsDirectory
            }
            else{
                do{
                    try fileManager.createDirectory(atPath: documentsDirectory, withIntermediateDirectories: true, attributes: nil)
                    return documentsDirectory
                }
                catch{
                    print(error)
                    return ""
                }
            }
        }
        else{
            if let appname = Bundle.main.displayName{
                documentsDirectory = (paths[0] as NSString).appendingPathComponent(appname + ".sqlite3") as String
                debugPrint(documentsDirectory)
                return documentsDirectory
            }
            else{
                debugPrint(documentsDirectory)
                return documentsDirectory
            }
            
        }
    }
    
    // MARK:- ALERT CONTROLLER
    func ShowAlert(view: UIViewController,message:String,Title:String)
    {
        let alert = UIAlertController(title: Title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            print(message)
        }))
        view.present(alert, animated: true, completion: nil)
    }
}

