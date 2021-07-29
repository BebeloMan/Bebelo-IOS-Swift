//
//  AddYourBarViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown
import WXImageCompress
class AddYourBarViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var AddBarTableView: UITableView!
    
    //ARRAY'S
    let headers_Array = [
        
        "Bar info".localized(),
        "Drink prices".localized(),
        "My bar has".localized(),
        "Contact Info".localized()
    ]
    
    let contactInfoArray = [
        ContactInfoModel(key:.cname,name: "Your name"),
        ContactInfoModel(key:.cphone,name: "Phone no",keyBoardType:.phonePad),
        ContactInfoModel(key:.cemail,name: "Email",keyBoardType:.emailAddress),
        ContactInfoModel(key:.cpassword,name: "Password",showText: true)
    ]
    
//    var drinkPriceArray = [DrinkPricesModelW(drinkName: "Caña", drinkImage: "d4"),
//                           DrinkPricesModelW(drinkName: "Doble", drinkImage: "d5"),
//                           DrinkPricesModelW(drinkName: "Tanqueray", drinkImage: "dd1"),
//                           DrinkPricesModelW(drinkName: "Beefeater", drinkImage: "dd2"),
//                           DrinkPricesModelW(drinkName: "Brugal Añejo", drinkImage: "dd3")
//    ]
    var drinkPriceArray = [
        DrinkPrices1ModelW(drinkCategory: "Beer", drinks: [
            DrinkPricesModelW(drinkName: .Caña , drinkImage: "d4"),
            DrinkPricesModelW(drinkName: .Doble, drinkImage: "d5")
        ]),
        DrinkPrices1ModelW(drinkCategory: "Normales", drinks: [
            DrinkPricesModelW(drinkName: .Tanqueray, drinkImage: "d1"),
            DrinkPricesModelW(drinkName: .Beefeater, drinkImage: "d2"),
            DrinkPricesModelW(drinkName: .Brugal, drinkImage: "d3"),
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
    
    
    
    var barInfoArray = [
        BarDetailModel(name: "Bar name"),
        BarDetailModel(name: "Address")
    ]
    
    var weekArray = [
        WeekDayModelW(name: "Monday", weekDay: weekfullDay.Monday.rawValue),
        WeekDayModelW(name: "Tuesday", weekDay: weekfullDay.Tuesday.rawValue),
        WeekDayModelW(name: "Wednesday", weekDay: weekfullDay.Wednesday.rawValue),
        WeekDayModelW(name: "Thursday", weekDay: weekfullDay.Thursday.rawValue),
        WeekDayModelW(name: "Friday", weekDay: weekfullDay.Friday.rawValue),
        WeekDayModelW(name: "Saturday", weekDay: weekfullDay.Saturday.rawValue),
        WeekDayModelW(name: "Sunday", weekDay: weekfullDay.Sunday.rawValue)
    ]
    
    //    let myBarHasArray = [
    //        "Terrace",
    //        "Rooftop"
    //    ]
    
    var myBarHasArray = [
        OnlyShowModelW(title: "Terrace"),
        OnlyShowModelW(title: "Rooftop")
    ]
    
//    let accountArray = [
//        "Email",
//        "Password"
//    ]
    
    //CONSTANT'S
    let image = UIImagePickerController()
    let dataPolicyIdentifier = "DataPolicyViewController"
    let exitIcon = "image 92"
    //VARIABLE'S
    var barImage = #imageLiteral(resourceName: "Group 97")
    var isImageEdited = false
    var delegate:PassDataDelegate?
    var settingsDelegate:SettingsViewController?
    var isCheckMarked = false
    var mainPickerView :  UIDatePicker!
    var mainToolBar : UIToolbar!
    var location = LocationModel()
    var barSupliment = SuplimentModelW(isSupliment: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(DoneBtnAction(_:))), animated: true)
            //self.navigationController?.title = "Add your bar".localized()
        self.navigationController?.navigationBar.isHidden = true
    }
    //IBACTION'S
    @IBAction func DoneBtnAction(_ sender: Any) {
        //delegate?.doneBtnDelegate()
        //self.navigationController?.popViewController(animated: true)
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.checkAllFieldValid()
        }
    }
    func checkAllFieldValid(){
        
        for barDetailModel in self.barInfoArray{
            if barDetailModel.value == nil{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter \(barDetailModel.name ?? "")".localized(), forViewController: self)
                return
            }
            else if barDetailModel.value.isEmpty{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter \(barDetailModel.name ?? "")".localized(), forViewController: self)
                return
            }
            
        }
//        for (i,drinkPricesModel) in self.drinkPriceArray.enumerated(){
//            for (j,drinkPrice) in drinkPricesModel.drinks.enumerated(){
//                if i == 1{
//                    if j == 0 || j == 1 || j == 2{
//                        if drinkPrice.drinkPrice == nil || drinkPrice.drinkPrice.isEmpty{
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter at least \(drinkPrice.drinkName ?? "") price", forViewController: self)
//                            return
//                        }
//                        else{
//                            if var price = drinkPrice.drinkPrice{
//                                price.removeAll { chr in
//                                    return chr == "€"
//                                }
//                                if price.isEmpty{
//                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter at least \(drinkPrice.drinkName ?? "") price", forViewController: self)
//                                    return
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//        }
        if barImage == #imageLiteral(resourceName: "Group 97"){
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add bar image".localized(), forViewController: self)
            return
        }
//        if !self.myBarHasArray.first!.isSelected {
//            if !self.myBarHasArray.last!.isSelected{
//                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please select atleast one bar sitting", forViewController: self)
//                return
//            }
//        }
        for arr in self.weekArray{
            if arr.svalue != nil && arr.evalue == nil{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add correct time".localized(), forViewController: self)
                return
            }
            else if arr.svalue == nil && arr.evalue != nil{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add correct time".localized(), forViewController: self)
                return
            }
        }
        let array = self.weekArray.filter { weekDayModelW in
            if weekDayModelW.svalue == 0 || weekDayModelW.svalue == nil || weekDayModelW.evalue == 0 || weekDayModelW.evalue == nil{
               return false
            }
            return true
        }
        if array.count > 0{
            
        }
        else{
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add atleast one hours".localized(), forViewController: self)
            return
        }
        
        for contactInfoModel in self.contactInfoArray { 
            if contactInfoModel.value  == nil{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter \(contactInfoModel.name ?? "")".localized(), forViewController: self)
                return
            }
            else if contactInfoModel.value.isEmpty{
                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter \(contactInfoModel.name ?? "")".localized(), forViewController: self)
                return
            }
            if contactInfoModel.key == .cpassword{
                if contactInfoModel.value.count < 6{
                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Password needs to be at least 6 characters".localized(), forViewController: self)
                    return
                }
            }
        }
        if !self.barSupliment.isSupliment{
            let sup = self.barSupliment
            if self.barSupliment.rate == nil{
                //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add supplement rate", forViewController: self)
                //return
            }else if self.barSupliment.type == nil{
                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add supplement type", forViewController: self)
                    //return
            }
        }
//        if !isCheckMarked{
//            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please accept privacy and policy", forViewController: self)
//            return
//        }
        createUser()
        
    }
    func createUser(){
        PopupHelper.showAnimating(controler:self)
        var user = UserModel.empty
        var email = "",pass = ""
        self.contactInfoArray.forEach { contactInfoModel in
            switch contactInfoModel.key{
            case .cemail:
                email = contactInfoModel.value
                user.cemail = contactInfoModel.value
            case .cpassword:
                pass = contactInfoModel.value
                user.cpassword = contactInfoModel.value
            case .cphone:
                user.cphone = contactInfoModel.value
            case .cname:
                user.cname = contactInfoModel.value
            default:
                break
            }
            
        }
        user.image = self.barImage.wxCompress().pngData()?.base64EncodedString()
        user.bname = self.barInfoArray.first!.value
        user.baddress = self.barInfoArray.last!.value
        user.blat = self.location.address_lat ?? 0.0
        user.blng = self.location.address_lng ?? 0.0
        
        var darray = [DrinkPricesModelW]()
        for drinkPrices1Model in self.drinkPriceArray {
            for drinkPricesModel in drinkPrices1Model.drinks {
                if drinkPricesModel.drinkPrice != "0" && drinkPricesModel.drinkPrice != "0.0"/* && drinkPricesModel.drinkPrice != ""*/{
                    if drinkPricesModel.drinkPrice == nil || drinkPricesModel.drinkPrice == ""{
                        switch drinkPricesModel.drinkName{
                        case .Caña,.Doble,.Tanqueray,.Beefeater,.Brugal:
                            drinkPricesModel.drinkPrice = "-"
                            darray.append(drinkPricesModel)
                        default:
                            break
                        }
                    }
                    else{
                        darray.append(drinkPricesModel)
                    }
                    
                }
                else{
                    switch drinkPricesModel.drinkName{
                    case .Caña,.Doble,.Tanqueray,.Beefeater,.Brugal:
                        drinkPricesModel.drinkPrice = "-"
                    default:
                        break
                    }
                    darray.append(drinkPricesModel)
                }
            }
        }
        
        darray.forEach { drinkPricesModelW in
            drinkPricesModelW.drinkPrice.removeAll { chr in
                return chr == "€"
            }
            drinkPricesModelW.drinkPrice = "\((Double(drinkPricesModelW.drinkPrice ?? "0") ?? 0).roundToPlace(places: 2))"
            if drinkPricesModelW.drinkPrice == "0"{
                drinkPricesModelW.drinkPrice = "-"
            }
        }
        if darray.count > 0{
            var finalArray1 = [DrinkPricesModelW]()
            for drinkPricesModelW in darray{
                for drinkPricesModel in self.drinkPriceArray[1].drinks{
                    if drinkPricesModel.drinkName == drinkPricesModelW.drinkName{
                        let _ = finalArray1.filter { drinkPricesModelW1 in
                            return drinkPricesModel.drinkName == drinkPricesModelW1.drinkName
                        }
                        finalArray1.append(drinkPricesModelW)
//                                                        if check.count == 0{
//                                                            finalArray.append(drinkPricesModelW)
//                                                        }
                    }
                }
            }
            var wordCounts = [Double: Int]()
            for word in finalArray1 {
                wordCounts[(word.drinkPrice ?? "0").replacingOccurrences(of: ",", with: ".").roundtoplace(), default: 0] += 1
            }
            let price = wordCounts.sorted(by: { key, key1 in
                return key.key < key1.key
            })
            var price1 = price.sorted(by: { key, key1 in
                return key.value > key1.value
            })
            price1.removeAll { (key, value) in
                return key == 0
            }
            if let prices = price1.first{
                user.displayPrice = "\(prices.key.roundToPlacee(places: 1))".replacingOccurrences(of: ",", with: ".")
            }
            else{
                user.displayPrice = "0"
            }
            
        }
        var botdic = [DrinkPricesModel]()
        darray.forEach { drinkPricesModelW in
            var dd = DrinkPricesModel()
            dd.drinkImage =  drinkPricesModelW.drinkImage
            dd.drinkName =  drinkPricesModelW.drinkName
            dd.drinkPrice =  drinkPricesModelW.drinkPrice
            botdic.append(dd)
        }
        user.barBottle = botdic
        //bar.barBottle = darray
        var wekdic = [WeekDayModel]()
        for week in self.weekArray{
            var dd = WeekDayModel()
            dd.svalue =  week.svalue
            dd.evalue =  week.evalue
            if let name = week.name{
                dd.name =  name.replacingOccurrences(of: "*", with: "")
            }
            else{
                dd.name = week.name
            }
            dd.weekDay =  weekfullDay(rawValue: week.weekDay)
            wekdic.append(dd)
        }
        user.barWeekDay = wekdic
        //bar.barWeekDay = self.weekArray
        var hasdic = [OnlyShowModel]()
        for barhas in self.myBarHasArray{
            var dd = OnlyShowModel()
            dd.isSelected =  barhas.isSelected
            dd.title =  barhas.title
            hasdic.append(dd)
        }
        user.barHas = hasdic
        user.deviceType = "IOS"
        user.userDate = Date().toMillisInt64()
        let uuid = String(Date().toMillisInt64()) + "0"
        user.uuid = Int64(uuid) ?? 0
        user.isFreeTable = false
        user.isSupliment = self.barSupliment.isSupliment
        user.isAnnounce = false
        FirebaseData.createUserData(email: email, password: pass) { result, error in
            if let error = error {
                PopupHelper.stopAnimating(controler: self)
                PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                return
            }
            FirebaseData.uploadProfileImage(image: self.barImage.wxCompress()) { url, error in
                if let error = error {
                    PopupHelper.stopAnimating(controler: self)
                    PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                    return
                }
                user.image = url
                FirebaseData.saveUserData(uid: (result?.user.uid)!, userData: user) { error in
                    
                    if let error = error {
                        PopupHelper.stopAnimating(controler: self)
                        PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                        return
                    }
                    var dic = [String:Any]()
                    dic["docid"] = FirebaseData.getCurrentUserId().0
                    self.callWebService(data:dic,action: .updateservice, .post)
                }
            }
        }
    }
    func loadAddress(_ location:LocationModel){
        self.location = location
        let index = IndexPath(row: 1, section: 0)
        let cell = self.AddBarTableView.cellForRow(at: index) as! ContactInfoTableViewCell
        cell.FieldTF.text = location.address_name
        self.barInfoArray[index.row].value = location.address_name
        self.AddBarTableView.reloadRows(at: [index], with: .automatic)
        
    }
    func callWebService(_ id:String? = nil,data: [String:Any]? = nil, action:webserviceUrl,_ httpMethod:httpMethod){
        
        WebServicesHelper.callWebService(Parameters: data,suburl: id, action: action, httpMethodName: httpMethod) { (indx,action,isNetwork, error, dataDict) in
            PopupHelper.stopAnimating(controler: self)
            if isNetwork{
                if let err = error{
                    PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        switch action {
                        case .updateservice:
                            print(dataDict)
                            var dic = [String:Any]()
                            dic[Constant.dob] = UserDefaults.standard.value(forKey: Constant.dob) as? String ?? "1999-11-11"
                            dic[Constant.sex] = UserDefaults.standard.value(forKey: Constant.sex) as? String ?? "male"
                            self.callWebService(data:dic,action: .adduserinfo, .post)
                            
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
                                    FirebaseData.saveUser2Data(uid: FirebaseData.getCurrentUserId().0, userData: data) { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                            return
                                        }
                                        self.navigationController?.popToRootViewController(animated: true)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? LocationViewController{
            controller.delagate = self
        }
    }
}

//MARK:- HELPING METHOD'S
extension AddYourBarViewController {
    
    func setupNavigationBar() {
        let yourBackImage = #imageLiteral(resourceName: "Arrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
    
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    func headerForTableView(tableView:UITableView)->UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 65))
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func labelForTableViewHeader(headerView:UIView) -> UILabel {
        let headerTitle = UILabel()
        
        let width: CGFloat = headerView.frame.width-16
        let height: CGFloat = headerView.frame.height
        
        headerTitle.frame = CGRect.init(x: 16, y: 0, width: width, height: height)
        headerTitle.textColor = UIColor(named: Constant.labelColor)
        headerTitle.backgroundColor = .clear
        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize17)
        return headerTitle
    }
}




//MARK:- UITABLEVIEW DELEGATE AND DATASOURCE
extension AddYourBarViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers_Array.count + self.drinkPriceArray.count + 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let headerView = Bundle.main.loadNibNamed("ContactInfoHeaderView", owner: self, options: nil)?.first as! ContactInfoHeaderView
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 65)
            headerView.backgroundColor = UIColor(named: "Background 4")
            headerView.lblName.text = self.headers_Array[section]
            headerView.lblDetail.text = ""//"(not shown in bar profile)"
            return headerView
        case 2:
            let headerView = Bundle.main.loadNibNamed("ContactInfoHeaderView", owner: self, options: nil)?.first as! ContactInfoHeaderView
            headerView.backgroundColor = UIColor(named: "Background 4")
            headerView.lblName.text = self.headers_Array[section - 1]
            headerView.lblDetail.text = ""//"(you can add more later)"
            return headerView
//        case 2,3,4,5:
            
        case 6:
            let headerView = headerForTableView(tableView: tableView)
            let headerTitle = labelForTableViewHeader(headerView: headerView)
            headerTitle.text = self.headers_Array[section - 4]
            headerView.addSubview(headerTitle)
            headerView.backgroundColor = UIColor(named: "Background 4")
            return headerView
        case 9:
            let headerView = Bundle.main.loadNibNamed("ContactInfoHeaderView", owner: self, options: nil)?.first as! ContactInfoHeaderView
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 65)
            headerView.backgroundColor = UIColor(named: "Background 4")
            headerView.lblName.text = self.headers_Array[section - 6]
            headerView.lblDetail.text = "(not shown in bar profile)".localized()
            return headerView
        default:
            return UIView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 3,4,5:
            return 0
        case 1,7,8,10:
            return 16
        default:
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return self.barInfoArray.count
        case 2,3,4,5:
            return self.drinkPriceArray[section - 2].drinks.count
        case 6:
            return self.myBarHasArray.count
        case 8:
            return self.weekArray.count + 1
        case 9:
            return self.contactInfoArray.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0: //MARK: BAR INFO
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.contactInfoTableViewCell) as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.barInfoArray[indexPath.row].name.localized()
            cell.TitleLabel.tag = indexPath.row
            
            cell.FieldTF.placeholder = self.barInfoArray[indexPath.row].name.replacingOccurrences(of: "*", with: "").localized()
            cell.FieldTF.text = self.barInfoArray[indexPath.row].value
            cell.FieldTF.tag = indexPath.row
            cell.FieldTF.accessibilityHint = "\(indexPath.section)"
            if self.barInfoArray[indexPath.row].name == "Address"{
                cell.FieldTF.isEnabled = false
                cell.FieldTF.delegate = nil
            }
            else{
                cell.FieldTF.isEnabled = true
                cell.FieldTF.delegate = self
            }
            cell.FieldTF.keyboardType = .default
            return cell
        case 2,3,4,5://MARK: BAR DRINK
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.addDrinksTableViewCell) as! AddDrinksTableViewCell
            cell.DrinkImage.image = UIImage(named: self.drinkPriceArray[indexPath.section - 2].drinks[indexPath.row].drinkImage ?? "")
            cell.TitleLabel.text = self.drinkPriceArray[indexPath.section - 2].drinks[indexPath.row].drinkName.rawValue
            cell.PriceField.setLeftPaddingPoints(4)
            cell.PriceField.setRightPaddingPoints(4)
            cell.PriceField.text = self.drinkPriceArray[indexPath.section - 2].drinks[indexPath.row].drinkPrice
            cell.PriceField.tag = indexPath.row
            cell.PriceField.accessibilityHint = "\(indexPath.section)"
            cell.PriceField.delegate = self
            cell.PriceField.keyboardType = .decimalPad
            cell.PriceField.addTarget(self, action: #selector(self.priceTextFieldChanged(_:)), for: .editingChanged)
            return cell
        case 1: //MARK: BAR INFO IMAGE
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barInfoImageTableViewCell) as! BarInfoImageTableViewCell
            cell.CaptureImage.image = self.barImage
            if self.isImageEdited{
                cell.EditImageBtn.isHidden = false
                cell.EditImageBtn.addTarget(self, action: #selector(self.editImageBtnAction(_:)), for: .touchUpInside)
            }else{
                cell.EditImageBtn.isHidden = true
            }
            return cell
        case 6: //MARK: ONLY SHOW
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.onlyShowTableViewCell) as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.myBarHasArray[indexPath.row].title.localized()
            if self.myBarHasArray[indexPath.row].isSelected {
                cell.ImageLabel.image = #imageLiteral(resourceName: "Rectangle 71")
                cell.BackImage.image = UIImage(named: "Filter row selected")
            }else{
                cell.ImageLabel.image = #imageLiteral(resourceName: "Rectangle 711")
                cell.BackImage.image = UIImage(named: "")
            }
            return cell
        case 7: //MARK: SUPPLEMENT
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.SupplimentTableViewCell) as! SupplimentTableViewCell
            if self.barSupliment.isSupliment{
                
                cell.btnNoCheck.setImage(#imageLiteral(resourceName: "Rectangle 711"), for: .normal)
                cell.btnYesCheck.setImage(#imageLiteral(resourceName: "Rectangle 71"), for: .normal)
                //cell.tfYes.isEnabled = true
                //cell.btnDropdown.isEnabled = false
                
            }
            else{
                //cell.tfYes.isEnabled = true
                //cell.btnDropdown.isEnabled = true
                cell.btnNoCheck.setImage(#imageLiteral(resourceName: "Rectangle 71"), for: .normal)
                cell.btnYesCheck.setImage(#imageLiteral(resourceName: "Rectangle 711"), for: .normal)
                
            }
            
            //if let rate = self.barSupliment.rate{
                //cell.tfYes.text = rate
            //}
            //else{
                //cell.tfYes.text = nil
            //}
            //if let type = self.barSupliment.type{
                //cell.btnDropdown.setTitle(type, for: .normal)
            //}
            //cell.tfYes.keyboardType = .numberPad
            //cell.tfYes.delegate = self
            //cell.tfYes.accessibilityHint = "\(indexPath.section)"
            cell.btnNoCheck.addTarget(self, action: #selector(self.suplemntCheckBtnPressed(_:)), for: .touchUpInside)
            cell.btnYesCheck.addTarget(self, action: #selector(self.suplemntCheckBtnPressed(_:)), for: .touchUpInside)
            //cell.btnDropdown.addTarget(self, action: #selector(self.supplementdropdown(_:)), for: .touchUpInside)
            return cell
        case 8: //MARK: OPENING HOURS
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openHoursHeaderTableViewCell) as! OpenHoursHeaderTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openingHourTableViewCell) as! OpeningHourTableViewCell
                if self.weekArray[indexPath.row - 1].name == nil{
                    cell.AddBtn.setImage(#imageLiteral(resourceName: "image 55"), for: .normal)
                    cell.AddBtn.removeTarget(self, action: #selector(self.addTimeBtnPressed(_:)), for: .touchUpInside)
                    cell.AddBtn.addTarget(self, action: #selector(self.removeTimeBtnPressed(_:)), for: .touchUpInside)
                }
                else{
                    cell.AddBtn.setImage(#imageLiteral(resourceName: "image 46"), for: .normal)
                    cell.AddBtn.removeTarget(self, action: #selector(self.removeTimeBtnPressed(_:)), for: .touchUpInside)
                    cell.AddBtn.addTarget(self, action: #selector(self.addTimeBtnPressed(_:)), for: .touchUpInside)
                }
                cell.AddBtn.tag = indexPath.row
                if let name = self.weekArray[indexPath.row - 1].name{
                    cell.WeekNameLabel.text = name.localized()
                }
                else{
                    cell.WeekNameLabel.text = nil
                }
                cell.tfStartDate.placeholder = "00:00"
                if let value = self.weekArray[indexPath.row - 1].svalue {
                    cell.tfStartDate.text = value.timestampToTimeString()
                }
                else{
                    cell.tfStartDate.text = nil
                }
                //cell.tfStartDate.text = self.weekArray[indexPath.row - 1].svalue.timestampToTime()
                cell.tfStartDate.keyboardType = .numberPad
                cell.tfStartDate.tag = indexPath.row
                cell.tfStartDate.accessibilityHint = "\(indexPath.section)"
                cell.tfStartDate.accessibilityValue = "s"
                cell.tfStartDate.delegate = self
                
                cell.tfEndDate.placeholder = "00:00"
                if let value = self.weekArray[indexPath.row - 1].evalue {
                    cell.tfEndDate.text = value.timestampToTimeString()
                }
                else{
                    cell.tfEndDate.text = nil
                }
                //cell.tfEndDate.text = self.weekArray[indexPath.row - 1].evalue.timestampToTime()
                cell.tfEndDate.keyboardType = .numberPad
                cell.tfEndDate.tag = indexPath.row
                cell.tfEndDate.accessibilityHint = "\(indexPath.section)"
                cell.tfEndDate.accessibilityValue = "e"
                cell.tfEndDate.delegate = self
                return cell
            }
        case 9: //MARK: ACCOUNT
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.contactInfoTableViewCell) as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.contactInfoArray[indexPath.row].name.localized()
            cell.TitleLabel.tag = indexPath.row
            cell.FieldTF.keyboardType = self.contactInfoArray[indexPath.row].keyBoardType
            cell.FieldTF.isSecureTextEntry = self.contactInfoArray[indexPath.row].showText
            cell.FieldTF.placeholder = self.contactInfoArray[indexPath.row].name.replacingOccurrences(of: "*", with: "").localized()
            cell.FieldTF.text = self.contactInfoArray[indexPath.row].value
            cell.FieldTF.tag = indexPath.row
            cell.FieldTF.accessibilityHint = "\(indexPath.section)"
            cell.FieldTF.delegate = self
            cell.FieldTF.isEnabled = true
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.termsAndConditionTableViewCell) as! TermsAndConditionTableViewCell
            //let termsGusture = UITapGestureRecognizer(target: self, action: #selector(self.termsOfUserAction(sender:)))
            //cell.TermsOfUseLabel.addGestureRecognizer(termsGusture)
            //cell.TermsOfUseLabel.isUserInteractionEnabled = true
            //let policyGusture = UITapGestureRecognizer(target: self, action: #selector(self.dataPolicyAction(ssender:)))
            //cell.DataPolicyLabel.addGestureRecognizer(policyGusture)
            //cell.DataPolicyLabel.isUserInteractionEnabled = true
            if self.isCheckMarked{
                cell.btnCheckMark.setImage(#imageLiteral(resourceName: "Rectangle 71"), for: .normal)
            }
            else{
                cell.btnCheckMark.setImage(#imageLiteral(resourceName: "Rectangle 711"), for: .normal)
                
            }
            cell.btnCheckMark.addTarget(self, action: #selector(self.checkBtnPressed(_:)), for: .touchUpInside)
            cell.btnCheckMark.isHidden = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 1{
                self.view.endEditing(true)
                self.performSegue(withIdentifier: "toLocate", sender: nil)
            }
        }
        else
        if indexPath.section == 1 { //MARK: BAR INFO IMAGE
            //Open Camera
            self.view.endEditing(true)
            tableView.deselectRow(at: indexPath, animated: true)
            self.CameraBottomSheet()
        } else if indexPath.section == 6 {
            self.view.endEditing(true)
            if self.myBarHasArray[indexPath.row].isSelected{
                for bar in self.myBarHasArray{
                    bar.isSelected = false
                }
                self.myBarHasArray[indexPath.row].isSelected = false
            }else{
                for bar in self.myBarHasArray{
                    bar.isSelected = false
                }
                self.myBarHasArray[indexPath.row].isSelected = true
            }
            tableView.reloadSections([indexPath.section], with: .none)
        } else if indexPath.section == 8 {
            self.view.endEditing(true)
            //self.weekArray.insert("", at: indexPath.row + 1)
            //tableView.reloadSections([indexPath.section], with: .none)
        }
    }
    
    //EDIT IMAGE BUTTON ACTION
    @objc func editImageBtnAction( _ sender:UIButton){
        self.CameraBottomSheet()
    }
    @objc func priceTextFieldChanged( _ sender:UITextField){
        if var data = sender.text{
            data.removeAll(where: { chr in
                return chr == "€"
            })
            if !data.isEmpty{
                sender.text = "\(data)€"
            }
            else{
                sender.text = nil
            }
        }
        else{
            sender.text = nil
        }
        var string = sender.text!
        if string.contains(","){
            string.removeAll(where: { chr in
                return chr == ","
            })
            string.removeAll(where: { chr in
                return chr == "€"
            })
            sender.text = string
            sender.text!.append(".€")
            
        }
        else if string.contains("٫"){
            string.removeAll(where: { chr in
                return chr == "٫"
            })
            string.removeAll(where: { chr in
                return chr == "€"
            })
            sender.text = string
            sender.text!.append(".€")
            
        }
        else {
            
        }
        
    }
    @objc func termsOfUserAction(sender:UITapGestureRecognizer){
        let vc = self.getViewController(identifier: dataPolicyIdentifier) as! DataPolicyViewController
        //        vc.vcTitle = "Terms Of Use"
        vc.navigationController?.title = "Terms Of Use".localized()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func dataPolicyAction(ssender:UITapGestureRecognizer){
        let vc = self.getViewController(identifier: "DataPolicyViewController") as! DataPolicyViewController
        vc.navigationController?.title = "Data Policy".localized()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func addTimeBtnPressed(_ sender:UIButton){
        self.view.endEditing(true)
        self.weekArray.insert(WeekDayModelW(weekDay:self.weekArray[sender.tag - 1].weekDay), at: sender.tag)
        self.AddBarTableView.reloadSections([8], with: .none)
    }
    @objc func removeTimeBtnPressed(_ sender:UIButton){
        self.view.endEditing(true)
        self.weekArray.remove(at: sender.tag - 1)
        self.AddBarTableView.reloadSections([8], with: .none)
    }
    @objc func checkBtnPressed(_ sender:UIButton){
        self.view.endEditing(true)
        if self.isCheckMarked{
            self.isCheckMarked = false
        }
        else{
            self.isCheckMarked = true
        }
        
        let contentOffset = self.AddBarTableView.contentOffset
        self.AddBarTableView.reloadData()
        //self.AddBarTableView.layoutIfNeeded()
        //self.AddBarTableView.setContentOffset(contentOffset, animated: false)
    }
    @objc func suplemntCheckBtnPressed(_ sender:UIButton){
        self.view.endEditing(true)
        if self.barSupliment.isSupliment{
            self.barSupliment.isSupliment = false
            self.barSupliment.rate = nil
            self.barSupliment.type = nil
        }
        else{
            self.barSupliment.isSupliment = true
        }
        self.AddBarTableView.reloadSections([7], with: .none)
    }
    @objc func supplementdropdown(_ sender: UIButton) {//3
        let dropDown = DropDown()
        dropDown.dataSource = ["€", "%"]//4
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal) //9
            self!.barSupliment.type = item
            dropDown.hide()
        }
      }
}


//MARK:- CAMERA METHIO'S EXTENSION
extension AddYourBarViewController {
    //BOTTOM SHEET WHICH WILL SHOW TWO OPTION [CAMERA AND GALLERY]
    func CameraBottomSheet() {
        let alert = UIAlertController(title: "Choose Image".localized(), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera".localized(), style: .default, handler: { _ in
            self.Selected_choise(choise: "Camera")
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery".localized(), style: .default, handler: { _ in
            self.Selected_choise(choise: "gallery")
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel".localized(), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    // THIS METHOD IS USE FOR CHOICE WHICH IS SELECTED BY USER
    func Selected_choise(choise:String){
        if choise == "gallery"{
            self.openGallery()
        }else{
            self.openCamera()
        }
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    //THIS METHODS WILL OPEN GALLERY FOR IMAGE SELECTION
    func openGallery() {
        image.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.mediaTypes = ["public.image", "public.movie"]
    }
    // THIS METHOD WILL OPEN CAMERA FOR CAPTURING IMAGE
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable (
            UIImagePickerController.SourceType.camera
        ) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Your device not supporting camera", forViewController: self)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            self.barImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.barImage = originalImage
        }
        self.isImageEdited = true
        self.AddBarTableView.reloadSections([1], with: .none)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddYourBarViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch Int64(textField.accessibilityHint ?? "0") {
            
        case 8:
            var filtr = false
            for (i,weekDayModelW) in self.weekArray.enumerated(){
                if weekDayModelW.svalue == nil{
                    if weekDayModelW.evalue == nil{
                        filtr = false
                    }
                    else{
                        filtr =  true
                        break
                    }
                }
                else{
                    if weekDayModelW.evalue == nil{
                        if textField.tag == i + 1{
                            filtr = false
                        }
                        else{
                            filtr =  true
                            break
                        }
                    }
                    else{
                        filtr = false
                    }
                }
            }
//            let filtr = self.weekArray.filter { weekDayModelW in
//                if weekDayModelW.svalue == nil{
//                    if weekDayModelW.evalue == nil{
//                        return false
//                    }
//                    else{
//                        return true
//                    }
//                }
//                else{
//                    if weekDayModelW.evalue == nil{
//                        return true
//                    }
//                    else{
//                        return
//                         false
//                    }
//                }
//            }
            if filtr{
                //textField.resignFirstResponder()
                //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill top time first".localized(), forViewController: self)
            }
//            if textField.accessibilityValue == "s"{
//                //self.createPickerView(textField)
//                if textField.text!.isEmpty{
//                    if textField.tag > 1{
//                        if self.weekArray[textField.tag - 2].svalue == nil && self.weekArray[textField.tag - 2].svalue == nil{
//                            textField.resignFirstResponder()
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill top time first", forViewController: self)
//                        }
//                        if self.weekArray[textField.tag - 2].evalue == nil {
//                            textField.resignFirstResponder()
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill top time first", forViewController: self)
//                        }
//                    }
//
//                }
//            }
//            else if textField.accessibilityValue == "e"{
//                //self.createPickerView(textField)
//                if textField.text!.isEmpty{
//                    if textField.tag > 1{
//                        if self.weekArray[textField.tag - 2].evalue == nil {
//                            textField.resignFirstResponder()
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill top time first", forViewController: self)
//                        }
//                        if self.weekArray[textField.tag - 2].svalue == nil {
//                            textField.resignFirstResponder()
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill top time first", forViewController: self)
//                        }
//                    }
//
//
//                }
//            }
        default:
            textField.becomeFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let section = Int(textField.accessibilityHint ?? "0") ?? 0
        switch section {
        case 0:
            self.barInfoArray[textField.tag].value = textField.text
        case 2,3,4,5:
            let text = textField.text?.dropLast()
            if text?.last == "."{
                textField.text?.removeLast()
                textField.text!.append("0€")
                self.drinkPriceArray[section - 2].drinks[textField.tag].drinkPrice = textField.text!
            }
            else{
                self.drinkPriceArray[section - 2].drinks[textField.tag].drinkPrice = textField.text
            }
            
        case 7:
            if textField.text!.isEmpty{
                self.barSupliment.isSupliment = true
                self.barSupliment.rate = nil
            }
            else{
                self.barSupliment.rate = textField.text!
                self.barSupliment.isSupliment = false
            }
            self.AddBarTableView.reloadSections([4], with: .none)
        case 8:
            if textField.accessibilityValue == "s"{
                if textField.text?.count == 2{
                    let timeformat = "\(textField.text!):00"
                    let time = timeformat.getTimeFromStringToDate().toMillisInt64()
                    if self.weekArray[textField.tag - 1].weekDay != nil{
                        
                        self.weekArray[textField.tag - 1].svalue = time
                        textField.text = timeformat
                    }
                    else if let s_time = self.weekArray[textField.tag - 1].svalue{
                        if time <= s_time{
                            //textField.text = nil
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                        }
                    }
                    else if let endtime = self.weekArray[textField.tag - 2].evalue{
                        if time <= endtime{
                            textField.text = nil
                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top end time after".localized(), forViewController: self)
                        }
                        else{
                            self.weekArray[textField.tag - 1].svalue = time
                            textField.text = timeformat
                        }
                    }
                    
                }
                else{
                    if !textField.text!.isEmpty{
                        if textField.text!.count > 4{
                            let time = textField.text!.getTimeFromStringToDate().toMillisInt64()
                            if self.weekArray[textField.tag - 1].weekDay != nil{
                                
                                self.weekArray[textField.tag - 1].svalue = time
                            }
                            else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                if time <= s_time{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                }
                            }
                            else if let endtime = self.weekArray[textField.tag - 2].evalue{
                                if time <= endtime{
                                    textField.text = nil
                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top".localized(), forViewController: self)
                                }
                                else{
                                    self.weekArray[textField.tag - 1].svalue = time
                                }
                            }
                        }
                        else if textField.text!.count == 1{
                            if textField.text! != "0"{
                                let timeformat = "\(textField.text!)0:00"
                                let time = timeformat.getTimeFromStringToDate().toMillisInt64()
                                if self.weekArray[textField.tag - 1].weekDay != nil{
                                    
                                    self.weekArray[textField.tag - 1].svalue = time
                                    textField.text = timeformat
                                }
                                else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                    if time <= s_time{
                                       // textField.text = nil
                                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                    }
                                }
                                else if let endtime = self.weekArray[textField.tag - 2].evalue{
                                    if time <= endtime{
                                        textField.text = nil
                                        PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top".localized(), forViewController: self)
                                    }
                                    else{
                                        self.weekArray[textField.tag - 1].svalue = time
                                        textField.text = timeformat
                                    }
                                }
                            }
                            else{
                                textField.text = nil
                            }
                            
                        }
                        else {
                            let timeformat = "\(textField.text!)0"
                            let time = timeformat.getTimeFromStringToDate().toMillisInt64()
                            if self.weekArray[textField.tag - 1].weekDay != nil{
                                
                                self.weekArray[textField.tag - 1].svalue = time
                                textField.text = timeformat
                            }
                            else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                if time <= s_time{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                }
                            }
                            else if let endtime = self.weekArray[textField.tag - 2].evalue{
                                if time <= endtime{
                                    textField.text = nil
                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top".localized(), forViewController: self)
                                }
                                else{
                                    self.weekArray[textField.tag - 1].svalue = time
                                    textField.text = timeformat
                                }
                            }
                        }
                        
                    }
                    else{
                        self.weekArray[textField.tag - 1].svalue = nil
                    }
                    
                }
                
            }
            else if textField.accessibilityValue == "e"{
                if textField.text?.count == 2{
                    let timeformat = "\(textField.text!):00"
                    let time = timeformat.getTimeFromStringToDate().toMillisInt64()
                    if self.weekArray[textField.tag - 1].weekDay != nil{
                        if let s_time = self.weekArray[textField.tag - 1].svalue{
                            if time <= s_time{
                                //textField.text = nil
                                //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                self.weekArray[textField.tag - 1].evalue = time
                                textField.text = timeformat
                            }
                            else{
                                self.weekArray[textField.tag - 1].evalue = time
                                textField.text = timeformat
                            }
                        }
                        else{
                            //textField.text = nil
                            //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                        }
                        
                    }
                    else if let s_time = self.weekArray[textField.tag - 1].svalue{
                        if time <= s_time{
                            textField.text = nil
                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the end time after".localized(), forViewController: self)
                        }
                        else{
                            self.weekArray[textField.tag - 1].evalue = time
                            textField.text = timeformat
                        }
                    }
                    else{
                        //textField.text = nil
                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                    }
//                    else if let endtime = self.weekArray[textField.tag - 2].evalue{
//                        if time < endtime{
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top", forViewController: self)
//                        }
//                    }
                    
                }
                else{
                    if !textField.text!.isEmpty{
                        if textField.text!.count > 4{
                            let time = textField.text!.getTimeFromStringToDate().toMillisInt64()
                            if self.weekArray[textField.tag - 1].weekDay != nil{
                                if let s_time = self.weekArray[textField.tag - 1].svalue{
                                    if time <= s_time{
                                        //textField.text = nil
                                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                        self.weekArray[textField.tag - 1].evalue = time
                                    }
                                    else{
                                        self.weekArray[textField.tag - 1].evalue = time
                                    }
                                }
                                else{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                }
                                
                                
                                
                            }
                            else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                if time <= s_time{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                    self.weekArray[textField.tag - 1].evalue = time
                                }
                                else{
                                    self.weekArray[textField.tag - 1].evalue = time
                                }
                            }
                            else{
                                //textField.text = nil
                                //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                            }
//                            else if let endtime = self.weekArray[textField.tag - 2].evalue{
//                                if time < endtime{
//                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top", forViewController: self)
//                                }
//                            }
                        }
                        else if textField.text!.count == 1{
                            if textField.text! != "0"{
                                let timeformat = "\(textField.text!)0:00"
                                let time = timeformat.getTimeFromStringToDate().toMillisInt64()
                                if self.weekArray[textField.tag - 1].weekDay != nil{
                                    if let s_time = self.weekArray[textField.tag - 1].svalue{
                                        if time <= s_time{
                                            //textField.text = nil
                                            //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                            self.weekArray[textField.tag - 1].evalue = time
                                            textField.text = timeformat
                                        }
                                        else{
                                            self.weekArray[textField.tag - 1].evalue = time
                                            textField.text = timeformat
                                        }
                                    }
                                    else{
                                        //textField.text = nil
                                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                    }
                                }
                                else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                    if time <= s_time{
                                        //textField.text = nil
                                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                    }
                                    else{
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
                                    }
                                }
                                else{
                                    textField.text = nil
                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the end time after".localized(), forViewController: self)
                                }
                            }
                            else{
                                textField.text = nil
                            }
                            
                        }
                        else {
                            let timeformat = "\(textField.text!)0"
                            let time = timeformat.getTimeFromStringToDate().toMillisInt64()
                            if self.weekArray[textField.tag - 1].weekDay != nil{
                                if let s_time = self.weekArray[textField.tag - 1].svalue{
                                    if time <= s_time{
                                        //textField.text = nil
                                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
                                    }
                                    else{
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
                                    }
                                }
                                else{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                }
                            }
                            else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                if time <= s_time{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                }
                                else{
                                    self.weekArray[textField.tag - 1].evalue = time
                                    textField.text = timeformat
                                }
                            }
                            else{
                                textField.text = nil
                                PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the end time after".localized(), forViewController: self)
                            }
//                            else if let endtime = self.weekArray[textField.tag - 2].evalue{
//                                if time < endtime{
//                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top", forViewController: self)
//                                }
//                            }
                        }
                        
                    }
                    else{
                        self.weekArray[textField.tag - 1].evalue = nil
                    }
                    
                }
            }
        case 9:
            self.contactInfoArray[textField.tag].value = textField.text
        default:
            break
        }
        
        self.view.endEditing(true)
        textField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch Int64(textField.accessibilityHint ?? "0") {
        case 1,2,3,4:
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92) {
                    if !textField.text!.isEmpty{
                        textField.text = String(textField.text!.dropLast(1))
                        return true
                    }
                }
                if textField.text!.contains("."){
                    if string == "."{
                        return false
                    }
                    else if string == ","{
                        return false
                    }
                    else if string == "٫"{
                        return false
                    }
                }
                else{
                    if string == ","{
                        //textField.text!.append(".")
                        return true
                    }
                    else if string == "٫"{
                        //textField.text!.append(".")
                        return true
                    }
                    else {
                        return true
                    }
                }
            }
        case 8:
            switch string{
            case "0","1","2":
                break
            case "3":
                if textField.text!.count >= 1 {
                    break
                }
                else{
                    return false
                }
            case "4":
                if textField.text!.count >= 1 {
                    if textField.text!.first == "2"{
                        return false
                    }
                    else{
                        break
                    }
                    
                }
                else{
                    return false
                }
            case "5":
                if textField.text!.count >= 1 {
                    if textField.text!.first == "2"{
                        if textField.text?.count == 2 || textField.text?.last == ":"{
                            break
                        }
                        else if textField.text!.count == 4{
                            break
                        }
                        else{
                            return false
                        }
                        
                    }
                    else{
                        break
                    }
                    
                }
                else{
                    return false
                }
            case "6":
                if textField.text!.count >= 1 {
                    if textField.text?.last == ":"{
                        if textField.text!.count == 3{
                            return false
                        }
                        else{
                            break
                        }
                        
                    }
                    else if textField.text!.count == 1{
                        if textField.text!.first == "2"{
                            return false
                        }
                        else{
                            break
                        }
                        
                    }
                    else if textField.text!.count == 4{
                        break
                    }
                    else{
                        return false
                    }
                }
                else{
                    return false
                }
            case "7":
                if textField.text!.count > 1 && textField.text!.count <= 3 {
                    return false
                }
                else if textField.text!.count < 1{
                    if textField.text!.count == 4{
                        break
                    }
                    else{
                        return false
                    }
                    
                }
                else{
                    if textField.text!.first == "2"{
                        if textField.text?.count == 4{
                            break
                        }
                        else{
                            return false
                        }
                        
                    }
                    else{
                        break
                    }
                }
            case "8":
                if textField.text!.count > 1 && textField.text!.count <= 3 {
                    return false
                }
                else if textField.text!.count < 1{
                    if textField.text!.count == 4{
                        break
                    }
                    else{
                        return false
                    }
                }
                else{
                    if textField.text?.count == 4{
                        break
                    }
                    else{
                        if textField.text!.first == "1" && textField.text!.count <= 1{
                            return true
                        }
                        else if textField.text!.first == "0" && textField.text!.count <= 1{
                            return true
                        }
                        else{
                            return false
                        }
                        
                    }
                }
            case "9":
                if textField.text!.count > 1 && textField.text!.count <= 3 {
                    return false
                }
                else if textField.text!.count < 1{
                    if textField.text!.count == 4{
                        break
                    }
                    else{
                        return false
                    }
                }
                else{
                    if textField.text?.count == 4{
                        break
                    }
                    else{
                        if textField.text!.first == "1" && textField.text!.count <= 1{
                            return true
                        }
                        else if textField.text!.first == "0" && textField.text!.count <= 1{
                            return true
                        }
                        else{
                            return false
                        }
                    }
                }
            default:
                if string.isEmpty{
                    return true
                }
                else{
                    return false
                }
                
            }
            if textField.text!.count == 2{
                if string.isEmpty{
                    //textField.text = String(textField.text?.dropLast() ?? "")
                    return true
                }
                else{
                    textField.text?.append(":")
                }
            }
            else if textField.text!.count == 5{
                if string.isEmpty{
                    //textField.text = String(textField.text?.dropLast() ?? "")
                    return true
                }
                return false
            }
            
        default:
            return true
        }
        
        return true
    }

    
}
extension AddYourBarViewController{
    func createPickerView(_ textField: UITextField)
    
    {
        
        
        mainPickerView = UIDatePicker()
        mainToolBar = UIToolbar()
        mainPickerView.tag = textField.tag
        mainPickerView.accessibilityValue = textField.accessibilityValue
        mainPickerView.datePickerMode = .time
        mainPickerView.preferredDatePickerStyle = .wheels
        //mainPickerView.delegate?.pickerView!(mainPickerView, didSelectRow: 0, inComponent: 0)
        mainToolBar.barStyle = .default
        mainToolBar.tintColor = UIColor().colorsFromAsset(name: .tabBtnColor)
       // mainToolBar.isTranslucent = false
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            mainPickerView.frame = CGRect(x: mainPickerView.frame.origin.x, y: mainPickerView.frame.origin.y, width: mainPickerView.frame.width, height: mainPickerView.frame.height+80)
            mainToolBar.frame = CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:70.0)
            //mainToolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 70)
            mainToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-50.0)
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            
        }
        else
        {
            if UIScreen.main.bounds.height <= 1136
            {
                mainPickerView.frame = CGRect(x: mainPickerView.frame.origin.x, y: mainPickerView.frame.origin.y, width: mainPickerView.frame.width, height: mainPickerView.frame.height)
                mainToolBar.frame = CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0)
                //mainToolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30)
                mainToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-5.0)
                label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                
            }
            else
            {
                
                mainPickerView.frame = CGRect(x: mainPickerView.frame.origin.x, y: mainPickerView.frame.origin.y, width: mainPickerView.frame.width, height: mainPickerView.frame.height+50)
                mainToolBar.frame = CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width, height:40.0)
                //mainToolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
                mainToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
                label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            }
            
        }
        
        mainToolBar.backgroundColor = UIColor().colorsFromAsset(name: .themeColor)
        let defaultButton = UIBarButtonItem(title: "Cancel".localized() , style: .plain, target: self, action: #selector(tappedCancelBarBtn))
        let doneButton = UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = textField.placeholder
        label.textAlignment = .center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        mainToolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        textField.inputAccessoryView = mainToolBar
        textField.inputView = mainPickerView
        
        
    }
    
    @objc func tappedCancelBarBtn()
    {
            
        
        self.view.endEditing(true)
        mainPickerView = nil
        mainToolBar = nil
          
    }
    @objc func donePressed()
    {
        if let cell = self.AddBarTableView.cellForRow(at: IndexPath(row: mainPickerView.tag, section: 5)) as? OpeningHourTableViewCell{
            switch mainPickerView.accessibilityValue {
            case "s":
                cell.tfStartDate.text = mainPickerView.date.formattedWith(Globals.__HH_mm)
                self.weekArray[mainPickerView.tag - 1].svalue = mainPickerView.date.toMillisInt64()
                cell.tfStartDate.resignFirstResponder()
            case "e":
                cell.tfEndDate.text = mainPickerView.date.formattedWith(Globals.__HH_mm)
                self.weekArray[mainPickerView.tag - 1].evalue = mainPickerView.date.toMillisInt64()
                cell.tfEndDate.resignFirstResponder()
            default:
                break
            }
            mainPickerView = nil
            mainToolBar = nil
        }
    }
}
