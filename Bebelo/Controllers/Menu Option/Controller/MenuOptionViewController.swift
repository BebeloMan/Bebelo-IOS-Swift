//
//  MenuOptionViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 12/07/2021.
//

import UIKit

class MenuOptionViewController: UIViewController {
    
    // IBOUTLET'S
    @IBOutlet weak var PopUpView: UIView!
    // @IBOutlet weak var PopupViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var FlagImage: UIImageView!
    @IBOutlet weak var IsThisYourBarBackView: UIView!
    @IBOutlet weak var FlagBackView: UIView!
    @IBOutlet weak var FlagTitleLabel: UILabel!
    
    //CONSTANT'S
    let unFlag = "whatsapp"//"image 56"
    let flag = "whatsapp"
    //VARIABLE'S
    var animationValue = CGFloat()
    var isFlagSelected = false
    var delegate:MapViewController!
    var selectedBar: UserModel!
    var visitor: VisitorModel!
    var user:User2Model!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        PopupViewBottomConstraint.constant = -160
        //        showMenuWithAnimation()
        
        
        self.loadData()
        addTapGuesturesOnOptionsView()
        addTapGuestureOnMainView()
    }
    func loadData(){
        if FirebaseData.getCurrentUserId().1{
            FirebaseData.getUser2Data(uid: FirebaseData.getCurrentUserId().0) { error, userData in
                guard let userData = userData else {
                    return
                }
                self.user = userData
                if let report = self.user.flag{
                    if let flags = report[self.selectedBar.id!] as? Bool{
                        if flags{
                            self.isFlagSelected = true
                            
                            self.FlagImage.image = UIImage(named: self.flag)
                            self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                        }
                        else{
                            self.isFlagSelected = false
                            self.FlagImage.image = UIImage(named: self.unFlag)
                            self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                        }
                    }
                    else{
                        self.isFlagSelected = false
                        self.FlagImage.image = UIImage(named: self.unFlag)
                        self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                    }
                }
                else{
                    self.isFlagSelected = false
                    self.FlagImage.image = UIImage(named: self.unFlag)
                    self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                }
            }
            
        }
        else{
            FirebaseData.getVisitorData(uid: FirebaseData.getCurrentUserId().0) { error, userData in
                guard let userData = userData else {
                    return
                }
                self.visitor = userData
                if let report = self.visitor.flag{
                    if let flags = report[self.selectedBar.id!] as? Bool{
                        if flags{
                            self.isFlagSelected = true
                            
                            self.FlagImage.image = UIImage(named: self.flag)
                            self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                        }
                        else{
                            self.isFlagSelected = false
                            self.FlagImage.image = UIImage(named: self.unFlag)
                            self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                        }
                    }
                    else{
                        self.isFlagSelected = false
                        self.FlagImage.image = UIImage(named: self.unFlag)
                        self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                    }
                }
                else{
                    self.isFlagSelected = false
                    self.FlagImage.image = UIImage(named: self.unFlag)
                    self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
                }
            }
            
        }
    }
    //IBOUTLET'S
    @IBAction func CloseBtnAction(_ sender: Any) {
        self.dismiss(animated: false){
            self.delegate.selectedBar = self.selectedBar
        }
    }
    
}

//MARK:- HELPING METHOD'S
extension MenuOptionViewController{
    
    //    func showMenuWithAnimation() {
    //        UIView.animate(withDuration: 3.0, animations: {
    //            self.view.layoutIfNeeded()
    //            self.PopupViewBottomConstraint.constant -= CGFloat(1.0)
    //        }, completion: {res in
    //                //Do something
    //        })
    //    }
    
    func addTapGuestureOnMainView() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(closeWhenClickOnBackView(_:)))
        self.view.addGestureRecognizer(tapGuesture)
    }
    
    func addTapGuesturesOnOptionsView() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(IsThisYourBarAction(_:)))
        IsThisYourBarBackView.addGestureRecognizer(viewTap)
        let flagTap = UITapGestureRecognizer(target: self, action: #selector(FlagAction(_:)))
        FlagBackView.addGestureRecognizer(flagTap)
    }
    
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    @objc func IsThisYourBarAction(_:UITapGestureRecognizer){
        self.dismiss(animated: true){
            self.delegate.bardeatail()
        }
    }
    
    @objc func FlagAction(_:UITapGestureRecognizer){
        // Move to next screen
        var data = [String:Any]()
        
        var dic = [String:Any]()
        if isFlagSelected{
            isFlagSelected = false
            self.FlagImage.image = UIImage(named: unFlag)
            self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
            if FirebaseData.getCurrentUserId().1{
                
                if let flags = self.user.flag{
                    dic = flags
                    dic[self.selectedBar.id!] = false
                }
                else{
                    dic[self.selectedBar.id!] = false
                }
                data[User2Keys.flag.rawValue] = dic
                FirebaseData.updateUser2Data(FirebaseData.getCurrentUserId().0, dic: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        FirebaseData.saveUser2Data(uid: FirebaseData.getCurrentUserId().0, userData: data) { error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            self.loadData()
                        }
                    }
                }
            }
            else{
                if let flags = self.visitor.flag{
                    dic = flags
                    dic[self.selectedBar.id!] = false
                }
                else{
                    dic[self.selectedBar.id!] = false
                }
                data[VisitorKeys.flag.rawValue] = dic
                FirebaseData.updateVisitorData(FirebaseData.getCurrentUserId().0, dic: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        FirebaseData.saveVisitorData(uid: FirebaseData.getCurrentUserId().0, userData: data) { error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            self.loadData()
                        }
                    }
                }
            }
            
        }
        else{
            isFlagSelected = true
            self.FlagImage.image = UIImage(named: flag)
            self.FlagTitleLabel.text = "Tell us if there is incorrect information".localized()
            if FirebaseData.getCurrentUserId().1{
                
                if let flags = self.user.flag{
                    dic = flags
                    dic[self.selectedBar.id!] = true
                }
                else{
                    dic[self.selectedBar.id!] = true
                }
                data[User2Keys.flag.rawValue] = dic
                FirebaseData.updateUser2Data(FirebaseData.getCurrentUserId().0, dic: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        FirebaseData.saveUser2Data(uid: FirebaseData.getCurrentUserId().0, userData: data) { error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            self.loadData()
                        }
                    }
                }
            }
            else{
                if let flags = self.visitor.flag{
                    dic = flags
                    dic[self.selectedBar.id!] = true
                }
                else{
                    dic[self.selectedBar.id!] = true
                }
                data[VisitorKeys.flag.rawValue] = dic
                FirebaseData.updateVisitorData(FirebaseData.getCurrentUserId().0, dic: data) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        FirebaseData.saveVisitorData(uid: FirebaseData.getCurrentUserId().0, userData: data) { error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            self.loadData()
                        }
                    }
                }
            }
        }
    }
    
    @objc func closeWhenClickOnBackView(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: false){
            self.delegate.selectedBar = self.selectedBar
        }
    }
    func callwebservice(_ param:[String:Any]? = nil,id:String? = nil,action:webserviceUrl,method:httpMethod){
        WebServicesHelper.callWebService(Parameters: param,suburl: id,action: action, httpMethodName: method) { indx,action,isNetwork, error, dataDict in
            
            PopupHelper.stopAnimating(controler: self)
            if isNetwork{
                if let err = error{
                    PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        switch action {
                        case .addreport:
                            if self.isFlagSelected{
                                self.selectedBar.status = "1"
                            }
                            else{
                                self.selectedBar.status = "0"
                            }
                            
//                            self.dismiss(animated: true){
//                                self.delegate.handleMapTap()
//                            }
//                            if let result = dic["result"] as? NSDictionary{
//                                self.dismiss(animated: true, completion: nil)
//                            }
//                            else if let message = dic["message"] as? String{
//                                PopupHelper.showAlertControllerWithError(forErrorMessage: message, forViewController: self)
//                            }
                            
                            
                        default:
                            break
                        }
                    }
                }
            }
            else{
                PopupHelper.alertWithNetwork(title: "Network Connection".localized(), message: "Please connect your internet connection".localized(), controler: self)
            }
        }
    }
}
