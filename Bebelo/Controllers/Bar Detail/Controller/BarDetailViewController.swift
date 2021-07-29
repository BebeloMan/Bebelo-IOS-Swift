//
//  BarDetailViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 08/07/2021.
//

import UIKit
import SwiftyJSON
class BarDetailViewController: UIViewController, AnnouncementProtocol {
    
    //IBOUTLET'S
    @IBOutlet weak var BarDetailTableView: UITableView!
    @IBOutlet weak var tabTwo: UIView!
    @IBOutlet weak var tabThree: UIView!
    
    
    var drinkPriceArray = [DrinkPricesModelW]()
    var drinkOtherArray = [DrinkPrices1ModelW]()
    
    //VARIABLE'S
    let barImage = UIImage(named: "image 18")
    let AnnouncementPopupIdentifier = "AnnouncementPopupViewController"
    let headerHeight: CGFloat = 65
    let buttonBackColor = "Button Bacground 2"
    let buttonBackColor2 = "Button Background 3"
    let anunciarBtnTitle = "Anunciar"
    let segmentOnBackColor = "SegmentOn"
    let editBarProfileIdentifier = "EditBarProfileViewController"
    var isTerraceSelected = false
    var isAnnounceAdded = false
    var userData =  UserModel.empty
    var barHas = [OnlyShowModel]()
    var isFirstTime = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.loadData()
//        if let ann = self.announceData {
//
//            if ann.date != nil{
//                if ann.date.check4Hours(){
//                    self.isAnnounceAdded = false
//                    self.announceData = nil
//                }
//                else{
//                    if let data = ann.data{
//                        if let byte = Data(base64Encoded: data){
//                            if String(data: byte, encoding: .utf8) == "Announce Something!".localized(){
//                                self.isAnnounceAdded = false
//                                self.announceData = nil
//                            }
//                            else{
//                                self.announceData = ann
//                                self.isAnnounceAdded = true
//                                self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//                            }
//                        }
//                        else{
//                            self.announceData = ann
//                            self.isAnnounceAdded = true
//                            self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//                        }
//                    }
//                    else{
//                        self.announceData = ann
//                        self.isAnnounceAdded = true
//                        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//                    }
//
//                }
//            }
//            else{
//                if let data = ann.data{
//                    if let byte = Data(base64Encoded: data){
//                        if String(bytes: byte, encoding: .utf8) == "Announce Something!".localized(){
//                            self.isAnnounceAdded = false
//                            self.announceData = nil
//                        }
//                        else{
//                            self.announceData = ann
//                            self.isAnnounceAdded = true
//                            self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//                        }
//                    }
//                    else{
//                        self.announceData = ann
//                        self.isAnnounceAdded = true
//                        self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//                    }
//
//                }
//                else{
//                    self.announceData = ann
//                    self.isAnnounceAdded = true
//                    self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//                }
//
//
//            }
//
//        }
//        if let freetable = self.freeTableData{
//
//            if freetable.date.check5Mins(){
//                self.freeTableData = nil
//                self.isTerraceSelected = false
//            }
//            else{
//                self.freeTableData = freetable
//                self.isTerraceSelected = true
//            }
//
//
//        }
//        if self.isFirstTime{
//            self.BarDetailTableView.reloadData()
            
//        }
//        else{
//            self.BarDetailTableView.reloadSections([0], with: .none)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
//                self.BarDetailTableView.reloadSections([0], with: .none)
//            }
            
//        }
        
        
    }
    
    @IBAction func EditBtnAction(_ sender: Any) {
        self.isFirstTime = true
        let announcementPopupVC = self.getViewController(identifier: editBarProfileIdentifier) as! EditBarProfileViewController
        announcementPopupVC.delegate = self
        self.navigationController?.pushViewController(announcementPopupVC, animated: true)
    }
    
    //DELEGATE'S
    func AnnouncementDeletegate(announce: String) {
        var user = [String:Any]()//self.userData
        user[UserKeyss.isAnnounce.rawValue] = true
        self.isAnnounceAdded = true
        user[UserKeyss.announceDate.rawValue] = Date().toMillisInt64()
        user[UserKeyss.announce.rawValue] = announce
        FirebaseData.updateUserData(FirebaseData.getCurrentUserId().0, dic: user) { error in
            //self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        
    }
    func loadArray(){
        self.drinkPriceArray = [
            DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "dd1"),
            DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "dd2"),
            DrinkPricesModelW(drinkName: .Brugal, drinkImage: "dd3")
            ]
        self.drinkOtherArray = [
            DrinkPrices1ModelW(drinkCategory: "Beer", drinks: [
                DrinkPricesModelW(drinkName: .Caña , drinkImage: "d4"),
                DrinkPricesModelW(drinkName: .Doble, drinkImage: "d5")
            ]),
            DrinkPrices1ModelW(drinkCategory: "Normales", drinks: [
                /*DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "d1"),
                DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "d2"),
                DrinkPricesModelW(drinkName: .Brugal, drinkImage: "d3"),*/
                DrinkPricesModelW(drinkName: .Seagram_s, drinkImage: "d6"),
                DrinkPricesModelW(drinkName: .Bombay_Sapphire , drinkImage: "d7"),
                DrinkPricesModelW(drinkName: .Barceló , drinkImage: "d8"),
                DrinkPricesModelW(drinkName: .Santa_Teresa , drinkImage: "d9"),
                DrinkPricesModelW(drinkName: .Cacique , drinkImage: "d10"),
                DrinkPricesModelW(drinkName: .Captain_Morgan , drinkImage: "d11"),
                DrinkPricesModelW(drinkName: .Johnnie_Walker_Red , drinkImage: "d12"),
                DrinkPricesModelW(drinkName: .J_n_B , drinkImage: "d13"),
                DrinkPricesModelW(drinkName: .Absolut , drinkImage: "d14"),
            ]),
            DrinkPrices1ModelW(drinkCategory: "High roller", drinks: [
                DrinkPricesModelW(drinkName: .Nordés , drinkImage: "d15"),
                DrinkPricesModelW(drinkName: .Bulldog , drinkImage: "d16"),
                DrinkPricesModelW(drinkName: .Hendrick_s , drinkImage: "d17"),
                DrinkPricesModelW(drinkName: .Martin_Miller_s , drinkImage: "d18"),
                DrinkPricesModelW(drinkName: .Brockman_s , drinkImage: "d19"),
                DrinkPricesModelW(drinkName: .Havana_Club_7 , drinkImage: "d20"),
                DrinkPricesModelW(drinkName: .Johnnie_Walker_Black , drinkImage: "d21"),
                DrinkPricesModelW(drinkName: .Jack_Daniel_s , drinkImage: "d22"),
                DrinkPricesModelW(drinkName: .Grey_Goose , drinkImage: "d23"),
                DrinkPricesModelW(drinkName: .Belvedere , drinkImage: "d24"),
            ]),
            DrinkPrices1ModelW(drinkCategory: "War time", drinks: [
                DrinkPricesModelW(drinkName: .Larios , drinkImage: "d25"),
                DrinkPricesModelW(drinkName: .Negrita , drinkImage: "d26"),
                DrinkPricesModelW(drinkName: .Dyc , drinkImage: "d27")
            ])
            ]
    }
    func loadData(){
        
        PopupHelper.showAnimating(controler:self)
        FirebaseData.getUserDataListener(uid: FirebaseData.getCurrentUserId().0) { error, userData in
            PopupHelper.stopAnimating(controler: self)
            guard let userData = userData else {
                FirebaseData.logout()
                return
            }
            self.loadArray()
            print(userData.isFreeTable)
            print(userData.bname)
            self.title = userData.bname
            self.userData = userData
            self.barHas.removeAll()
            for bar in userData.barHas!{
                self.barHas.append(bar)
            }
            if let drinkArray = userData.barBottle{
                self.drinkPriceArray.forEach { drinkPricesModel in
                    for var drink in drinkArray{
                        if drinkPricesModel.drinkName == drink.drinkName{
                            drinkPricesModel.drinkPrice = drink.drinkPrice
                            drink.drinkPrice = nil
                            break
                        }
                        
                    }
                }
                self.drinkOtherArray.forEach { drinkPrices1Model in
                     for drinkPrices in drinkPrices1Model.drinks{
                        for drinks in drinkArray{
                            if drinks.drinkName == drinkPrices.drinkName{
                                drinkPrices.drinkPrice = drinks.drinkPrice
                                
                            }
                            
                        }
                    }
                }
            }
            self.drinkPriceArray.removeAll { drinkPricesModel in
                return drinkPricesModel.drinkPrice == "0" || drinkPricesModel.drinkPrice == nil
            }
            self.drinkOtherArray.removeAll { drinkPrices1Model in
                drinkPrices1Model.drinks.removeAll(where: { drinkPricesModel in
                    return drinkPricesModel.drinkPrice == "0" || drinkPricesModel.drinkPrice == nil
                })
                return drinkPrices1Model.drinks.count == 0
            }
            if self.isFirstTime{
                self.isFirstTime = false
                self.BarDetailTableView.reloadData()
            }
            else{
                self.BarDetailTableView.reloadSections([0], with: .none)
            }
            
//            if let ann = userData.announce {
//                if let date = userData.announceDate{
//                    if date.check4Hours(){
//                        self.isAnnounceAdded = false
//                        self.updateAnnounce()
//
//                    }
//                    else{
//                        self.announceData = ann
//                        self.isAnnounceAdded = true
//                    }
//                }
//                else{
//                    self.isAnnounceAdded = false
//                    self.updateAnnounce()
//                }
//
//
//            }
//            else{
//                self.isAnnounceAdded = false
//            }
//            if let freetable = bar.freeTable{
//
//                if freetable.date.check5Mins(){
//                    self.isTerraceSelected = false
//                    self.updateTerrace()
//                }
//                else{
//                    self.freeTableData = freetable
//                    self.isTerraceSelected = true
//                }
//
//
//            }

        }
        
    }
}

//MARK:- HELPING METHOD'S
extension BarDetailViewController{
    
    func setupNavigationBar() {
        let yourBackImage = UIImage(named: Constant.exitIcon)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
    
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    func headerForTableView(tableView:UITableView)->UIView {
        let headerView = UIView.init(frame: CGRect.init(x: Constant.tableviewHeaderXY, y: Constant.tableviewHeaderXY, width: tableView.frame.width, height: Constant.tableviewHeaderHeight))
        headerView.backgroundColor = UIColor(named: "Background 4")
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
        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize19)
        return headerTitle
    }
}


//MARK:- UITABLEVIEW DELEGATES AND DATASOURCE
extension BarDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.drinkOtherArray.count + 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0,1,2:
            let headerView = headerForTableView(tableView: tableView)
            let headerTitle = labelForTableViewHeader(headerView: headerView)
            headerTitle.text = ""
            headerView.addSubview(headerTitle)
            return headerView
        default:
            let headerView = headerForTableView(tableView: tableView)
            let headerTitle = labelForTableViewHeader(headerView: headerView)
            headerTitle.text = self.drinkOtherArray[section - 3].drinkCategory.localized()
            headerView.addSubview(headerTitle)
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 || section == 2{
            return 16
        }
        else{
            return 65
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.barHas.count > 0{
                if self.barHas.first!.isSelected || self.barHas.last!.isSelected{
                    return 2
                }
                else{
                    return 1
                }
            }
            else{
                return 1
            }
            
            
        }else if section == 1{
            return 1
        }else if section == 2{
            return self.drinkPriceArray.count
        }else{
            return self.drinkOtherArray[section - 3].drinks.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.announcementTableViewCell) as! AnnouncementTableViewCell
                cell.BackView.shadowColor = .systemGray6
                cell.SideImage.image = UIImage(named: "Ellipse 7")
                if self.userData.isAnnounce{
                    if let ann = self.userData.announce{
                        cell.DeailLabel.text = "Active for 4 hours".localized()
                        cell.Title.text = ann
                        isAnnounceAdded = true
                    }
                    else{
                        cell.Title.text = "Announce Something!".localized()
                        cell.DeailLabel.text = "Active during 4 hours".localized()
                        isAnnounceAdded = false
                    }
                }
                else{
                    cell.Title.text = "Announce Something!".localized()
                    cell.DeailLabel.text = "Active during 4 hours".localized()
                    isAnnounceAdded = false
                }
                

                let titleGusture = UITapGestureRecognizer(target: self, action: #selector(self.announcementEditable(sender:)))
                cell.BackView.addGestureRecognizer(titleGusture)
                
                if isAnnounceAdded == true {
                    cell.AnunciaBtn.isHidden = false
                    cell.AnunciaBtn.setImage(#imageLiteral(resourceName: "image 62"), for: .normal)
                    cell.AnunciaBtn.backgroundColor = .clear
                    
                    cell.BackView.shadowColor = UIColor(named: buttonBackColor)
                    
                }else{
                    cell.AnunciaBtn.setImage(#imageLiteral(resourceName: "image 81"), for: .normal)
                    
                    cell.BackView.shadowColor = .systemGray6
                }
                
                //Add target on anunciar
                cell.AnunciaBtn.addTarget(self, action: #selector(self.announcementButtonAction(_:)), for: .touchUpInside)
                cell.AnunciaBtn.tag = indexPath.row
                cell.selectionStyle = .none
                return cell
                
            }else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FreeTableViewCell") as! FreeTableViewCell
                cell.BackView.shadowColor = .systemGray6
                cell.SideImage.image = UIImage(named: "Ellipse 7-1")
                if self.userData.isFreeTable{
                    
                    cell.DeailLabel?.text = "Active for 5 minutes".localized()
                }
                else{
                    cell.DeailLabel?.text = "Active for 5 minutes".localized()
                }
                cell.Title.text = "Free table on terrace".localized()
                self.isTerraceSelected = self.userData.isFreeTable
                cell.TarraceAsegment.isHidden = false
                cell.Title.isEditable = false
                cell.Title.isSelectable = false
                cell.TarraceAsegment.addTarget(self, action: #selector(self.terraceSwitchButtonAction(_:)), for: .valueChanged)
                cell.TarraceAsegment.tag = indexPath.row
                for gest in cell.BackView.gestureRecognizers ?? []{
                    cell.BackView.removeGestureRecognizer(gest)
                }
                
                if self.isTerraceSelected{
                    cell.BackView.shadowColor = UIColor(named: segmentOnBackColor)
                    cell.TarraceAsegment.setOn(true, animated: false)
                }
                else{
                    cell.BackView.shadowColor = .systemGray6
                    cell.TarraceAsegment.setOn(false, animated: false)
                }
                
                //Add target on segment control
                cell.selectionStyle = .none
                return cell
            }
            else{
                return UITableViewCell()
            }
            
            
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barGalleryTableViewCell) as! BarGalleryTableViewCell
            let placeholder = #imageLiteral(resourceName: "Image")
            if let imagstr = self.userData.image{
                if let url = URL(string: imagstr){
                    
//                    let mURLRequest = NSURLRequest(url: url)
                    let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
//
//                    let imageDownloader = UIImageView.af.sharedImageDownloader
//                    _ = imageDownloader.imageCache?.removeImage(for: mURLRequest as URLRequest, withIdentifier: nil)
                    cell.BarImage.af.setImage(withURLRequest: urlRequest, placeholderImage: placeholder, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true)
                }
                else{
                    cell.BarImage.image = placeholder
                }
            }
            else{
                cell.BarImage.image = placeholder
            }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.mainCategoryTableViewCell) as! MainCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.drinkPriceArray[indexPath.row].drinkImage)
            cell.ProductNameLabel.text = self.drinkPriceArray[indexPath.row].drinkName.rawValue
            if let price = self.drinkPriceArray[indexPath.row].drinkPrice{
                if price.contains("-"){
                    cell.ProductPriceLabel.text = "-"
                }
                else{
                    cell.ProductPriceLabel.text = "€\(price)".replacingOccurrences(of: ",", with: ".")
                }
                
            }
            else{
                cell.ProductPriceLabel.text = "€0.0"
            }
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.otherCategoryTableViewCell) as! OtherCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.drinkOtherArray[indexPath.section - 3].drinks[indexPath.row].drinkImage)
            cell.ProductNameLabel.text = self.drinkOtherArray[indexPath.section - 3].drinks[indexPath.row].drinkName.rawValue
            if let price = self.drinkOtherArray[indexPath.section - 3].drinks[indexPath.row].drinkPrice{
                if price.contains("-"){
                    cell.ProductPriceLabel.text = "-"
                }
                else{
                    cell.ProductPriceLabel.text = "€\(price)".replacingOccurrences(of: ",", with: ".")
                }
            }
            else{
                cell.ProductPriceLabel.text = "€0.0"
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    @objc func announcementEditable(sender:UITapGestureRecognizer) {
        let announcementPopupVC = self.getViewController(identifier: AnnouncementPopupIdentifier) as! AnnouncementPopupViewController
        announcementPopupVC.delegate = self
        self.present(announcementPopupVC, animated: true, completion: nil)
        //let cell = self.BarDetailTableView.dequeueReusableCell(withIdentifier: Constant.announcementTableViewCell) as! AnnouncementTableViewCell
        //cell.AnunciaBtn.isHidden = false
    }
    
    @objc func announcementButtonAction( _ sender:UIButton) {
        
        if self.isAnnounceAdded{
            self.updateAnnounce(false)
            
        }
        else{
            let announcementPopupVC = self.getViewController(identifier: AnnouncementPopupIdentifier) as! AnnouncementPopupViewController
            announcementPopupVC.delegate = self
            self.present(announcementPopupVC, animated: true, completion: nil)
        }
            
    }
    
    @objc func terraceSwitchButtonAction( _ sender:UISegmentedControl?) {
        
        if self.isTerraceSelected {
            self.isTerraceSelected = false
        }
        else{
            self.isTerraceSelected = true
        }
        self.updateTerrace()
        
    }
    func updateAnnounce(_ isAnnounce:Bool = false,anounce:String? = nil){
        var user = [String:Any]()//self.userData
        user[UserKeyss.announce.rawValue] = anounce
        user[UserKeyss.announceDate.rawValue] = 0
        user[UserKeyss.isAnnounce.rawValue] = isAnnounce
        FirebaseData.updateUserData(FirebaseData.getCurrentUserId().0, dic: user) { error in
            self.userData.announce = anounce
            self.userData.announceDate = 0
            self.userData.isAnnounce = isAnnounce
            self.BarDetailTableView.reloadSections([0], with: .none)
        }
    }
    func updateTerrace(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
            var user = [String:Any]()//self.userData
            user[UserKeyss.isFreeTable.rawValue] = self.isTerraceSelected
            user[UserKeyss.freeTableDate.rawValue] = Date().toMillisInt64()
            FirebaseData.updateUserData(FirebaseData.getCurrentUserId().0, dic: user) { error in
    //            if self.isFirstTime{
    //                if self.barData.barHas.first!.isSelected || self.barData.barHas.last!.isSelected{
    //                    self.BarDetailTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    //                }
    //                else{
    //                    self.BarDetailTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    //                }
    //
    //            }
    //            else{
    //                self.BarDetailTableView.reloadData()
    //                self.isFirstTime = true
    //            }
            }
        }
        
    }
}


extension BarDetailViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Announce Something!".localized(){
            textView.text = nil
            let indexPath = IndexPath(row: textView.tag, section: 0)
            let cell = self.BarDetailTableView.cellForRow(at: indexPath) as! AnnouncementTableViewCell
            cell.AnunciaBtn.isHidden = true
        }
        else{
            
        }
        
        }
        
    //}
    func textViewDidEndEditing(_ textView: UITextView) {
        let indexPath = IndexPath(row: textView.tag, section: 0)
        let cell = self.BarDetailTableView.cellForRow(at: indexPath) as! AnnouncementTableViewCell
        if textView.text.isEmpty || textView.text == "Announce Something!".localized(){
            textView.text = "Announce Something!".localized()
            
            cell.AnunciaBtn.setImage(#imageLiteral(resourceName: "image 81"), for: .normal)
            cell.AnunciaBtn.setTitle("", for: .normal)
        }
        else{
            cell.BackView.shadowColor = UIColor(named: buttonBackColor)
            cell.AnunciaBtn.setImage(#imageLiteral(resourceName: "image 62"), for: .normal)
            cell.AnunciaBtn.setTitle("", for: .normal)
            cell.AnunciaBtn.backgroundColor = .clear
        }
    }
}
