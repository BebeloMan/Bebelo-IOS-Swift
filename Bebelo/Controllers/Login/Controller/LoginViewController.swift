//
//  LoginViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 08/07/2021.
//

import UIKit

class LoginViewController: UIViewController {
    //IBOUTLET'S
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    var delegate:UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //IBACTION'S
    @IBAction func LoginButtonAction(_ sender: Any) {
        if self.EmailTF.text!.isEmpty || self.PasswordTF.text!.isEmpty{
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Invalid User".localized(), forViewController: self)
            return
        }
        else if !self.EmailTF.text!.isValidEmail(){
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Invalid User".localized(), forViewController: self)
            return
        }
        PopupHelper.showAnimating(controler:self)
        UserDefaults.standard.setValue(FirebaseData.getCurrentUserId().0, forKey: Constant.idTokken)
        FirebaseData.loginUserData(email: self.EmailTF.text!, password: self.PasswordTF.text!) { result, error in
            PopupHelper.stopAnimating(controler: self)
            if let err = error{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Invalid User".localized(), forViewController: self)
                return
            }
            FirebaseData.getUser2Data(uid: FirebaseData.getCurrentUserId().0) { error, userData in
                if let err = error{
                    var dic = [String:Any]()
                    dic[Constant.dob] = UserDefaults.standard.value(forKey: Constant.dob) as? String ?? "1999-11-11"
                    dic[Constant.sex] = UserDefaults.standard.value(forKey: Constant.sex) as? String ?? "male"
                    self.callWebService(data:dic,action: .adduserinfo, .post,index: 1)
                    return
                }
                var dic = [String:Any]()
                dic[Constant.dob] = UserDefaults.standard.value(forKey: Constant.dob) as? String ?? "1999-11-11"
                dic[Constant.sex] = UserDefaults.standard.value(forKey: Constant.sex) as? String ?? "male"
                self.callWebService(data:dic,action: .adduserinfo, .post,index: 2)
                
            }
            
            
        }
        
    }
    
    @IBAction func AddItHereBtnAction(_ sender: Any) {
        let vc = self.getViewController(identifier: "AddYourBarViewController") as! AddYourBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ForgotPasswordBtnAction(_ sender: Any) {
        PopupHelper.alertContactusViewController(controler: self)
        //let vc = self.getViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    func callWebService(_ id:String? = nil,data: [String:Any]? = nil, action:webserviceUrl,_ httpMethod:httpMethod,index:Int = 0){
        
        WebServicesHelper.callWebService(Parameters: data,suburl: id, action: action, httpMethodName: httpMethod,index) { (indx,action,isNetwork, error, dataDict) in
            PopupHelper.stopAnimating(controler: self)
            if isNetwork{
                if let err = error{
                    PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        switch action {
                        
                            
                        case .adduserinfo:
                            if let dic = dataDict as? Dictionary<String,Any>{
                                if let user = dic[Constant.user_id] as? Int64{
                                    UserDefaults.standard.setValue(user, forKey: Constant.user_id)
                                    var data = [String:Any]()
                                   
                                    data[VisitorKeys.date.rawValue] = UserDefaults.standard.value(forKey: Constant.dob) as? String ?? "1999-11-11"
                                    data[VisitorKeys.gender.rawValue] = UserDefaults.standard.value(forKey: Constant.sex) as? String ?? "male"
                                    data[VisitorKeys.timestamp.rawValue] = Date().toMillisInt64()
                                    data[VisitorKeys.updatedOn.rawValue] = Date().formattedWith(Globals.__yyyy_MM_dd)
                                    data[VisitorKeys.user_id.rawValue] = user
                                    if indx == 1{
                                        FirebaseData.saveUser2Data(uid: FirebaseData.getCurrentUserId().0, userData: data) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                                
                                            }
                                            if let controler = self.delegate as? SettingsViewController{
                                                controler.doneBtnDelegate()
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                        }
                                    }
                                    else if indx == 2{
                                        FirebaseData.updateUser2Data(FirebaseData.getCurrentUserId().0, dic: data) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                                
                                            }
                                            if let controler = self.delegate as? SettingsViewController{
                                                controler.doneBtnDelegate()
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                        }
                                    }
                                    else{
                                        if let controler = self.delegate as? SettingsViewController{
                                            controler.doneBtnDelegate()
                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                        default:
                            break
                        }
                    }
                    else{
                        PopupHelper.showAlertControllerWithError(forErrorMessage: "something went wrong", forViewController: self)
                    }
                }
            }
            else{
                PopupHelper.alertWithNetwork(title: "Network Connection", message: "Please connect your internet connection", controler: self)
                
            }
        }
    }
    
}


//MARK:- HELPING METHOD'S
extension LoginViewController{
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
}
