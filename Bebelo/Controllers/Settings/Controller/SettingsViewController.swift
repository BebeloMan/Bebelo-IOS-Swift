//
//  SettingsViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit

class SettingsViewController: UIViewController,PassDataDelegate {
    
    //IBACTION'S
    @IBOutlet weak var SettingsTableview: UITableView!
    
    //ARRAY'S
    let headers_Array = [
        "",
        "Bar profile",
        "Only show",
        "Community",
        "The boring stuff"
    ]
    
    let onlyShowArray = [
        "Terrace",
        "Rooftop"
    ]
    
    let theBorringStuffArray = [
        "Terms of use",
        "Data policy"
    ]
    
    //VARIABLE'S
    let exitIcon = "exit"
    var isTerraceSelected = true
    var isProfileEntered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
    }
    
}

//MARK:- DELEGATE METHOD'S
extension SettingsViewController{
    
    func doneBtnDelegate() {
        self.isProfileEntered = true
        self.SettingsTableview.reloadData()
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
        let y: CGFloat = 25.33
        let width: CGFloat = headerView.frame.width-20
        let height: CGFloat = headerView.frame.height-20
        
        headerTitle.frame = CGRect.init(x: x, y: y, width: width, height: height)
        headerTitle.textColor = UIColor(named: Constant.labelColor)
        headerTitle.backgroundColor = .clear
        headerTitle.font = UIFont(name: Constant.openSansFont, size: Constant.fontSize)
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
        headerTitle.text = self.headers_Array[section]
        headerView.addSubview(headerTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }else{
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return self.onlyShowArray.count
        } else if section == 3 {
            return 1
        } else {
            return self.theBorringStuffArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddBarTableViewCell") as! AddBarTableViewCell
            if self.isProfileEntered{
                cell.TitleLabel.text = "Perrachica"
                cell.SideImage.image = UIImage(named: "image 17")
                cell.LoginBtn.isHidden = true
                cell.AlreadyEnterdLabel.isHidden = true
                cell.ForwordArrow.isHidden = true
            } else {
                cell.TitleLabel.text = "Add your bar"
                cell.SideImage.image = UIImage(named: "image 44")
            }
            cell.AddYourBarBtn.addTarget(self, action: #selector(self.addYourBarButtonAction(_:)), for: .touchUpInside)
            cell.LoginBtn.addTarget(self, action: #selector(self.loginButtonAction(_:)), for: .touchUpInside)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyShowTableViewCell") as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.onlyShowArray[indexPath.row]
            if indexPath.row == 0 {
                cell.ImageLabel.image = UIImage(named: "image 38")
                cell.BackImage.image = UIImage(named: "Filter row selected")
            }else{
                cell.ImageLabel.image = UIImage(named: "")
                cell.BackImage.image = UIImage(named: "")
            }
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as! CommunityTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BorringStuffTableViewCell") as! BorringStuffTableViewCell
            cell.TitleLabel.text = self.theBorringStuffArray[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            //UIApplication.shared.canOpenURL(URL(string: "http://instagram.com/")!)
            if let url = URL(string: "http://instagram.com/"){
                if UIApplication.shared.canOpenURL(url)
                {
                    UIApplication.shared.openURL(url)
                }
            }
        }else if indexPath.section == 4{
            self.performSegue(withIdentifier: "TermAndPolicy", sender: nil)
        }
    }
    
    @objc func addYourBarButtonAction( _ sender:UIButton){
        if isProfileEntered {
            let vc = self.getViewController(identifier: "BarDetailViewController") as! BarDetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.getViewController(identifier: "AddYourBarViewController") as! AddYourBarViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func loginButtonAction( _ sender:UIButton){
        let vc = self.getViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
