//
//  SettingsViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit
import AlamofireImage
import SwiftyJSON
class SettingsViewController: UIViewController,PassDataDelegate {
    
    //IBACTION'S
    @IBOutlet weak var SettingsTableview: UITableView!
    @IBOutlet weak var tabTwo: UIView!
    @IBOutlet weak var tabThree: UIView!
    //ARRAY'S
    var headers_Array = [
        "",
        "Bar profile",
        "Only show",
        "Community",
        "",
        "",
        "The boring stuff"
    ]
    var onlyShowArray = [
        OnlyShowModelW(title: "Terraces"),
        OnlyShowModelW(title:"Rooftops")
    ]
    
    let theBorringStuffArray = [
        "Terms of use",
        "Data policy"
    ]
    
    //VARIABLE'S
    let exitIcon = "Arrow"
    var isTerraceSelected = true
    var isProfileEntered = false
    var userData = UserModel.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        if FirebaseData.getCurrentUserId().1{
            self.tabTwo.isHidden = true
            self.tabThree.isHidden = false
            PopupHelper.showAnimating(controler:self)
            FirebaseData.getUserData(uid: FirebaseData.getCurrentUserId().0) { error, userData in
                PopupHelper.stopAnimating(controler: self)
                guard let userData = userData else {
                    FirebaseData.logout()
                    return
                }
                self.isProfileEntered = true
                self.userData = userData
                
                if let barhas = CommonHelper.getOnlyShowData(){
                    self.onlyShowArray = barhas
                }
                
                self.SettingsTableview.reloadData()

            }
        }
        else{
            self.tabTwo.isHidden = false
            self.tabThree.isHidden = true
            if let barhas = CommonHelper.getOnlyShowData(){
                self.onlyShowArray = barhas
            }
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        CommonHelper.saveOnlyShowData(self.onlyShowArray)
    }
    @objc func gotoSetting(){
        PopupHelper.gotoSetting()
    }
    
}

//MARK:- DELEGATE METHOD'S
extension SettingsViewController{
    
    func doneBtnDelegate() {
        self.isProfileEntered = true
        self.SettingsTableview.reloadData()
        //ADD NEW TABBAR ITEM
        
        if FirebaseData.getCurrentUserId().1{
            self.tabTwo.isHidden = true
            self.tabThree.isHidden = false
        }
        else{
            self.tabTwo.isHidden = false
            self.tabThree.isHidden = true
        }
    }
}

//MARK:- HELPING METHOD'S
extension SettingsViewController {
    
    func setupNavigationBar() {
        let yourBackImage = UIImage(named: exitIcon)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
    
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    func headerForTableView(tableView:UITableView)->UIView {
        let headerView = UIView.init(frame: CGRect.init(x: Constant.tableviewHeaderXY, y: Constant.tableviewHeaderXY, width: tableView.frame.width, height: Constant.tableviewHeaderHeight))
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func labelForTableViewHeader(headerView:UIView) -> UILabel {
        let headerTitle = UILabel()
        let x: CGFloat = 21
        let y: CGFloat = 45
        let width: CGFloat = headerView.frame.width-20
        let height: CGFloat = headerView.frame.height-20
        
        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
        headerTitle.textColor = UIColor(named: Constant.labelColor)
        headerTitle.backgroundColor = .clear
        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize19)
        return headerTitle
    }
}

extension SettingsViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers_Array.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = headerForTableView(tableView: tableView)
        let headerTitle = labelForTableViewHeader(headerView: headerView)
        headerTitle.text = self.headers_Array[section].localized()
        headerView.addSubview(headerTitle)
        headerView.backgroundColor = UIColor(named: "Background 4")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            let isLocationAccess = UserDefaults.standard.bool(forKey: Constant.locationAccessKey)
            if isLocationAccess == true{
                return 20
            }else{
                return 14
            }
        }
        if section == 4 || section == 5{
            return 0
        }
        else{
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let isLocationAccess = UserDefaults.standard.bool(forKey: Constant.locationAccessKey)
            if isLocationAccess == true{
                return 0
            }else{
                return 1
            }
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return self.onlyShowArray.count
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        }else if section == 5 {
            return 1
        }else {
            return self.theBorringStuffArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
            cell.OpenAppBtn.addTarget(self, action: #selector(self.gotoSetting), for: .touchUpInside)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddBarTableViewCell") as! AddBarTableViewCell
            if self.isProfileEntered{
                if let name = self.userData.bname{
                    cell.TitleLabel.text = name
                }
                else{
                    cell.TitleLabel.text = "I am a bar".localized()
                }
                let placeholder = #imageLiteral(resourceName: "Profile2")
                if let imagstr = self.userData.image{
                    if let url = URL(string: imagstr){
                        cell.SideImage.af.setImage(withURL: url, placeholderImage: placeholder, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true){_ in
                            cell.SideImage.cornerRadius = cell.SideImage.frame.height/2
                        }
                    }
                    else{
                        cell.SideImage.image = placeholder
                    }
                }
                else{
                    cell.SideImage.image = placeholder
                }
                
                cell.LoginBtn.isHidden = true
                cell.AlreadyEnterdLabel.isHidden = true
                cell.ForwordArrow.isHidden = true
            } else {
                cell.TitleLabel.text = "Add your bar".localized()
                cell.SideImage.image = UIImage(named: "image 44")
            }
            cell.AddYourBarBtn.addTarget(self, action: #selector(self.addYourBarButtonAction(_:)), for: .touchUpInside)
            cell.LoginBtn.addTarget(self, action: #selector(self.loginButtonAction(_:)), for: .touchUpInside)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyShowTableViewCell") as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.onlyShowArray[indexPath.row].title.localized()
            
            if self.onlyShowArray[indexPath.row].isSelected {
                cell.ImageLabel.image = #imageLiteral(resourceName: "Rectangle 71")
                cell.BackImage.image = UIImage(named: "Filter row selected")
                cell.TitleLabel.textColor = .white
                cell.TitleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 15)
            }else{
                cell.ImageLabel.image = #imageLiteral(resourceName: "Rectangle 711")
                cell.BackImage.image = UIImage(named: "")
                cell.TitleLabel.textColor = .black
                cell.TitleLabel.font = UIFont(name: "OpenSans-Regular", size: 15)
            }
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as! CommunityTableViewCell
            cell.ivImage.image = #imageLiteral(resourceName: "image 129")
            cell.TitleLabel.text = "Tell a friend".localized()
            return cell
        }
        else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as! CommunityTableViewCell
            cell.ivImage.image = #imageLiteral(resourceName: "whatsapp")
            cell.TitleLabel.text = "Do you want to contribute? Write us!".localized()
            return cell
        }
        else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as! CommunityTableViewCell
            cell.ivImage.image = #imageLiteral(resourceName: "image 37")
            cell.TitleLabel.text = "Write to us! @bebelo.es".localized()
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BorringStuffTableViewCell") as! BorringStuffTableViewCell
            cell.TitleLabel.text = self.theBorringStuffArray[indexPath.row].localized()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 1{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.section == 2{
            
            if self.onlyShowArray[indexPath.row].isSelected{
                self.onlyShowArray[indexPath.row].isSelected = false
            }else{
                self.onlyShowArray[indexPath.row].isSelected = true
            }
            
            self.SettingsTableview.reloadData()
        }
        if indexPath.section == 3 {
            let vc = UIActivityViewController(activityItems: [Constant.shareUrl], applicationActivities: [])
    //        vc.excludedActivityTypes = [.airDrop,.assignToContact,.copyToPasteboard,.mail,.markupAsPDF,.message,.openInIBooks,.print,.saveToCameraRoll]
            self.present(vc, animated: true, completion: nil)
            
            
        }
        else if indexPath.section == 5 {
            
            if let url = URL(string: "https://www.instagram.com/bebelo.es/"){
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else if indexPath.section == 6{
            if indexPath.row == 0{
                let vc = self.getViewController(identifier: "PrivacyViewController") as! PrivacyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = self.getViewController(identifier: "TermsViewController") as! TermsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func addYourBarButtonAction( _ sender:UIButton){
        if isProfileEntered {
            let vc = self.getViewController(identifier: "NavBarDetailViewController") as! UINavigationController
//            self.navigationController?.pushViewController(vc, animated: true)
            self.sideMenuController?.rootViewController = vc
        } else {
            let vc = self.getViewController(identifier: "AddYourBarViewController") as! AddYourBarViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func loginButtonAction( _ sender:UIButton){
        let vc = self.getViewController(identifier: "LoginViewController") as! LoginViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
