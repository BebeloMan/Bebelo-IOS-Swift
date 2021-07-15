//
//  SelectedBarDetailViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit

class SelectedBarDetailViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var BarDetailTableView: UITableView!
    @IBOutlet weak var OptionMenuBtn: UIButton!
    @IBOutlet weak var CloseBtn: UIButton!
    @IBOutlet weak var NavBarImage: UIImageView!
    
    //ARRAY'S
    let headers_Array = [
        "",
        "",
        "Cerveza"
    ]
    let MainCategoryImages = [
        "Bombay-1",
        "Bombay",
        "image 4"
    ]
    let MainCategoryTitle = [
        "Bombay Sapphire",
        "Havanna Club",
        "Jameson"
    ]
    
    //VARIABLE'S
    let ShowBarSegue = "ShowBar"
    var isBarItemHide = false
    var delegate:MapViewController!
    var isPreviousClose = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        hideOrUnhideNavItems()
    }
    
    //IBACTION'S
    @IBAction func OptionBtnAction(_ sender: Any) {
        let optionView = self.getViewController(identifier: "MenuOptionViewController") as! MenuOptionViewController
        optionView.delegate = self
        self.present(optionView, animated: true, completion: nil)
    }
    
    @IBAction func CloseBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showfullviewAction(_ sender: Any) {
        if isPreviousClose == false{
            self.dismissSemiModalViewWithCompletion {
                self.delegate.showFullView()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SelectedBarProfileViewController{
            controller.delegate = self.delegate
            controller.delegate1 = self
        }
        if let controller = segue.destination as? SelectedBarDetailViewController{
            controller.delegate = self.delegate
        }
    }
    
}

//MARK:- Delegate Method's
extension SelectedBarDetailViewController{
    
    func bardeatail(){
        // Delegate methods which call My Bar Profile view controller
        self.performSegue(withIdentifier: ShowBarSegue, sender: nil)
    }
    
}

//MARK:- HELPING METHOD'S
extension SelectedBarDetailViewController{
    
    func navigationBarSetup() {
        self.navigationController?.navigationBar.isHidden = false
        let yourBackImage = UIImage(named: Constant.navigationBackImage)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
    }
    
    func hideOrUnhideNavItems() {
        if isBarItemHide == true{
            CloseBtn.isHidden = true
            OptionMenuBtn.isHidden = true
            NavBarImage.isHidden = false
        }else{
            CloseBtn.isHidden = false
            OptionMenuBtn.isHidden = false
            NavBarImage.isHidden = true
        }
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

//MARK:- UITABLEVIEW DELEGATES AND DATASOURCE METHOD'S
extension SelectedBarDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
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
        if section == 2{
            return 65
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return self.MainCategoryImages.count
        }else{
            return self.MainCategoryImages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barDetailTableViewCell) as! BarDetailTableViewCell
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
            cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
            cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
            return cell
        }
    }
}
