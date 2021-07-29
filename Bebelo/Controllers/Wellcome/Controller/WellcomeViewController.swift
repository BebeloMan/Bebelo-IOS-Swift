//
//  WellcomeViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit
import LGSideMenuController
import CoreLocation
import IQKeyboardManagerSwift
class WellcomeViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var FieldsBorder: UIView!
    @IBOutlet weak var MaleBtn: UIButton!
    @IBOutlet weak var FemaleBtn: UIButton!
    @IBOutlet weak var DayTF: UITextField!
    @IBOutlet weak var MonthTF: UITextField!
    @IBOutlet weak var YearTF: UITextField!
    @IBOutlet weak var EnterBtn: UIButton!
    @IBOutlet weak var fieldConst: NSLayoutConstraint!
    
    
    //VARIABLE'S
    var isGenderSelected = false
    let dayDigitLimit = 2
    let monthDigitLimit = 2
    let yearDigitLimit = 4
    
    let distanceFilter: CLLocationDistance = 50
    var myLocation = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    var gender = "none"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        IQKeyboardManager.shared.enable = false
        self.userLocationSetup()
        let heiht = UIScreen.main.bounds.height
        switch heiht{
        case Globals.iphone_SE2_8_7_6s_6_hieght2,Globals.iphone_SE1_5_5s_5c_hieght1:
            self.fieldConst.constant = -100
        case Globals.iphone_11ProMax_11_XsMax_XR_hieght7,Globals.iphone_13Pro_13_12Pro_12_hieght6:
            self.fieldConst.constant = -80
        case Globals.iphone_13m_12m_11pro_XS_X_hieght4:
            self.fieldConst.constant = -90
        default:
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    //IBACTION'S
    @IBAction func MaleBtnAction(_ sender: Any) {
        changeGenderBtnBorder(type: true)
        self.gender = "male"
    }
    
    @IBAction func DateTextFields(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            if sender.text!.count >= 2{
                DayTF.resignFirstResponder()
                MonthTF.becomeFirstResponder()
            }
        case 1:
            if sender.text!.count >= 2{
                MonthTF.resignFirstResponder()
                YearTF.becomeFirstResponder()
            }
        case 2:
            if sender.text!.count >= 4{
                YearTF.resignFirstResponder()
            }
        default:
            break
        }
    }
    
    @IBAction func FemaleBtnAction(_ sender: Any) {
        changeGenderBtnBorder(type: false)
        self.gender = "female"
    }
    
    @IBAction func EnterBtnAction(_ sender: Any) {
        
        if self.ValidateDate(){
            PopupHelper.showAnimating(controler: self)
            var data = [String:Any]()
            let dob = "\(self.YearTF.text!)-\(self.MonthTF.text!)-\(self.DayTF.text!)"
            data[VisitorKeys.date.rawValue] = dob
            data[VisitorKeys.gender.rawValue] = self.gender
            data[VisitorKeys.timestamp.rawValue] = Date().toMillisInt64()
            data[VisitorKeys.updatedOn.rawValue] = Date().formattedWith(Globals.__yyyy_MM_dd)
            FirebaseData.loginAnonymusUserData { result, error in
                guard let result = result else {
                    return
                }
                var data1 = [String:Any]()
                data1["dob"] = dob
                data1["sex"] = self.gender
                WebServicesHelper.callWebService(Parameters:data1,action: .adduserinfo, httpMethodName: .post) { indx,action,isNetwork, error, dataDict in
                    if isNetwork{
                        if let err = error{
                            PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                        }
                        else{
                            if let dic = dataDict as? Dictionary<String,Any>{
                                if let user = dic[Constant.user_id] as? Int64{
                                    data[VisitorKeys.user_id.rawValue] = user
                                    FirebaseData.saveVisitorData(uid: result.user.uid, userData: data) { error in
                                        self.stopAnimating()
                                        if let error = error {
                                            print(error.localizedDescription)
                                            return
                                        }
                                        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "LGSideMenuController") as! LGSideMenuController
                                        UIApplication.shared.windows.first?.rootViewController = viewController
                                    }
                                    UserDefaults.standard.set(user, forKey: Constant.user_id)
                                    UserDefaults.standard.set(dob, forKey: Constant.dob)
                                    UserDefaults.standard.set(user, forKey: Constant.sex)
                                }
                            }
                        }
                    }
                    else{
                        PopupHelper.alertWithNetwork(title: "Network Connection", message: "Please connect your internet connection", controler: self)
                    }
                }
                
            }
           
        }else{
            PopupHelper.alertWithOk(title: "Error", message: "Date of birth and gender is not selected please provide date of birth and select gender or your age must be 18+".localized(), controler: self)
        }
    }
    func userLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = distanceFilter
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        locationManager.delegate = self
    }
}

// MARK:- INITIAL SETTING OF USER INTERFACE (UI)
extension WellcomeViewController{
    func changeGenderBtnBorder(type:Bool) {
        EnterBtn.backgroundColor = UIColor(named: "Button Background")
        self.isGenderSelected = true
        if type{ //MALE
            MaleBtn.borderColor = UIColor(named: "Button Border")
            MaleBtn.backgroundColor = UIColor(named: "Button text 2")
            MaleBtn.setTitleColor(.white, for: .normal)
            FemaleBtn.borderColor = UIColor(named: "Textfield Placeholder")
            FemaleBtn.backgroundColor = .white
            FemaleBtn.setTitleColor(UIColor(named: "Button Border"), for: .normal)
        }else{// FEMALE
            MaleBtn.borderColor = UIColor(named: "Textfield Placeholder")
            MaleBtn.backgroundColor = .white
            MaleBtn.setTitleColor(UIColor(named: "Button Border"), for: .normal)
            FemaleBtn.borderColor = UIColor(named: "Button Border")
            FemaleBtn.backgroundColor = UIColor(named: "Button text 2")
            FemaleBtn.setTitleColor(.white, for: .normal)
        }
    }
}

// MARK: HELPING METHOD'S
extension WellcomeViewController{
    /*THIS METHOS WILL SETUP USER INTERFACE INITIAL SETTINGS*/
    func ValidateDate() -> Bool{
        if DayTF.text != " " || DayTF.text != "", MonthTF.text != " " || MonthTF.text != "",YearTF.text != " " || YearTF.text != ""{
            let day = Int(DayTF.text ?? "0") ?? 0
            let month = Int(MonthTF.text ?? "0") ?? 0
            let year = Int(YearTF.text ?? "0") ?? 0
            if day > 0 && day <= 31 && month > 0 && month <= 12 && year > 1900 {
                let date = "\(YearTF.text!)-\(MonthTF.text!)-\(DayTF.text!)".getDateFromStringToDate()
                if date.underAge(){
                    return true
                }
                else{
                    return false
                }
            }else {
                return false
            }
        }else{
            return false
        }
    }
}
extension WellcomeViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            UserDefaults.standard.set(false, forKey: Constant.locationAccessKey)
            // Display the map using the default location.
            PopupHelper.alertWithAppSetting(title: "Alert", message: "Please enable your location", controler: self)
        case .notDetermined:
            print("Location status not determined.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("Location status is OK.")
            UserDefaults.standard.set(true, forKey: Constant.locationAccessKey)
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Unknown case found")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    //    //MARK: CHANGE CURRENT LOCATION ICON DEGREE FOR ROUTATION
    //    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    //        let direction = -newHeading.trueHeading as Double
    //        userLocationMarker.icon = self.imageRotatedByDegrees(degrees: CGFloat(direction), image: UIImage(named: "Me")!)
    //    }
    //
    //    func imageRotatedByDegrees(degrees: CGFloat, image: UIImage) -> UIImage{
    //        let size = image.size
    //
    //        UIGraphicsBeginImageContext(size)
    //        let context = UIGraphicsGetCurrentContext()
    //
    //        context!.translateBy(x: 0.5*size.width, y: 0.5*size.height)
    //        context!.rotate(by: CGFloat(DegreesToRadians(degrees: Double(degrees))))
    //
    //        image.draw(in: CGRect(origin: CGPoint(x: -size.width*0.5, y: -size.height*0.5), size: size))
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        return newImage!
    //    }
    //
    //    func setLatLonForDistanceAndAngle(userLocation: CLLocation) -> Double {
    //        let lat1 = DegreesToRadians(degrees: userLocation.coordinate.latitude)
    //        let lon1 = DegreesToRadians(degrees: userLocation.coordinate.longitude)
    //
    //        let lat2 = DegreesToRadians(degrees: 37.7833);
    //        let lon2 = DegreesToRadians(degrees: -122.4167);
    //
    //        let dLon = lon2 - lon1;
    //
    //        let y = sin(dLon) * cos(lat2);
    //        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    //        var radiansBearing = atan2(y, x);
    //        if(radiansBearing < 0.0)
    //        {
    //            radiansBearing += 2*M_PI;
    //        }
    //
    //        return radiansBearing;
    //    }
}
