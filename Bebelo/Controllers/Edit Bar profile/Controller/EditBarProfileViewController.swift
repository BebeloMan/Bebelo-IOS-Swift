//
//  EditBarProfileViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit
import LGSideMenuController
import WXImageCompress
import DropDown
class EditBarProfileViewController: UIViewController {
    
    @IBOutlet weak var EditBarProfileTableView: UITableView!
    
    //VARIABLE'S empty 4
    let headers_Array = [
        "",
        "My bar has".localized(),
        "",
        "",
        "Bar info".localized(),
        "Contact info".localized(),
        ""
    ]
    
    let descriptionArray = ["If you stock the drink, fill in the price and it will appear in your bar profile. If not, leave it empty Typography".localized(),"(not shown in bar profile)".localized()]
    
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
    let contactInfoArray = [
        ContactInfoModel(key:.userName,name: "Your name"),
        ContactInfoModel(key:.phoneNumber,name: "Phone no",keyBoardType:.phonePad)
    ]
    var barInfoArray = [
        BarDetailModel(name: "Bar name"),
        BarDetailModel(name: "Address")
    ]
    var weekArray = [
        WeekDayModel(name: weekfullDay.Monday.rawValue, weekDay: .Monday),
        WeekDayModel(name: weekfullDay.Tuesday.rawValue, weekDay: .Tuesday),
        WeekDayModel(name: weekfullDay.Wednesday.rawValue, weekDay: .Wednesday),
        WeekDayModel(name: weekfullDay.Thursday.rawValue, weekDay: .Thursday),
        WeekDayModel(name: weekfullDay.Friday.rawValue, weekDay: .Friday),
        WeekDayModel(name: weekfullDay.Saturday.rawValue, weekDay: .Saturday),
        WeekDayModel(name: weekfullDay.Sunday.rawValue, weekDay: .Sunday)
    ]
    var myBarHasArray = [
        OnlyShowModelW(title: "Terrace"),
        OnlyShowModelW(title: "Rooftop")
    ]
    
    let image = UIImagePickerController()
    let filterRowImage = "Filter row selected"
    let markImage = "image 38"
    let dataPolicyViewController = "DataPolicyViewController"
    let termsOfUseTitle = "Terms Of Use"
    let dataPolicyTitle = "Data Policy"
    var barImage = #imageLiteral(resourceName: "Group 97")
    var isImageEdited = false
    var delegate:BarDetailViewController!
    var userData = UserModel.empty
    var barData = BarModelW()
    var mainPickerView :  UIDatePicker!
    var mainToolBar : UIToolbar!
    var location = LocationModel()
    var barSupliment = SuplimentModelW(isSupliment: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.title = "Edit bar profile".localized()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Done".localized(), style: .plain, target: self, action: #selector(DoneBtnAction(_:))), animated: true)
    }
    //IBACTION'S
    @objc func DoneBtnAction(_ sender: Any) {
        
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.checkAllFieldValid()
        }
        
    }
    func checkAllFieldValid(){
        
        for barDetailModel in self.barInfoArray {
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
//                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter at least \(drinkPrice.drinkName.rawValue ?? "") price", forViewController: self)
//                            return
//                        }
//                        else{
//                            if var price = drinkPrice.drinkPrice{
//                                price.removeAll { chr in
//                                    return chr == "€"
//                                }
//                                if price.isEmpty{
//                                    PopupHelper.showAlertControllerWithError(forErrorMessage: "Please Enter at least \(drinkPrice.drinkName.rawValue ?? "") price", forViewController: self)
//                                    return
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//        }
        
        if isImageEdited == false{
            //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please add bar image", forViewController: self)
            //return
        }
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
//        if !self.myBarHasArray.first!.isSelected {
//            if !self.myBarHasArray.last!.isSelected{
//                let data = FreeTableModelW()
//                data.freeTable = false
//                data.date = Date().toMillisInt64()
//                CommonHelper.saveCachedFreeTableData(data)
//            }
//        }
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
        self.updateBar()
        //checkUser()
    }
    func checkUser(){
        PopupHelper.showAnimating(controler:self)
        self.callwebservice(id:self.userData.id,action: .getsingle, method: .get)
    }
    func updateBar(){
        PopupHelper.showAnimating(controler:self)
        var user = self.userData
        user.uuid = self.userData.uuid
        user.cemail = self.userData.cemail
        user.cemail = self.userData.cemail
        user.cpassword = self.userData.cpassword
        user.deviceType = self.userData.deviceType
        user.token = self.userData.token
        user.userDate = self.userData.userDate
        user.isAnnounce = self.userData.isAnnounce
        user.announce = self.userData.announce
        user.announceDate = self.userData.announceDate
        user.isFreeTable = self.userData.isFreeTable
        user.freeTableDate = self.userData.freeTableDate
        user.isopend = self.userData.isopend
        user.displaytime = self.userData.displaytime
        user.displayPrice = self.userData.displayPrice
        user.status = self.userData.status
        user.isAdded = self.userData.isAdded
        user.closingtype = self.userData.closingtype
        user.image = self.userData.image
        
        user.cname = self.contactInfoArray.first!.value
        user.cphone = self.contactInfoArray.last!.value
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
            wekdic.append(week)
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
        user.isSupliment = self.barSupliment.isSupliment
//        if !self.myBarHasArray.first!.isSelected {
//            if !self.myBarHasArray.last!.isSelected{
//                let data = FreeTableModelW()
//                data.freeTable = false
//                data.date = Date().toMillisInt64()
//                CommonHelper.saveCachedFreeTableData(data)
//                bar.freeTable = data
//            }
//        }
        if self.isImageEdited{
            FirebaseData.uploadProfileImage(image: self.barImage.wxCompress()) { url, error in
                if let error = error {
                    PopupHelper.stopAnimating(controler: self)
                    PopupHelper.showAlertControllerWithError(forErrorMessage: error.localizedDescription, forViewController: self)
                    return
                }
                user.image = url
                FirebaseData.updateUserData(FirebaseData.getCurrentUserId().0, dic: user) { error in
                    
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
        else{
            FirebaseData.updateUserData(FirebaseData.getCurrentUserId().0, dic: user) { error in
                
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
    func callWebService(_ id:String? = nil,data: [String:Any]? = nil, action:webserviceUrl,_ httpMethod:httpMethod){
        
        WebServicesHelper.callWebService(Parameters: data,suburl: id, action: action, httpMethodName: httpMethod) { (indx,action,isNetwork, error, dataDict) in
            self.stopAnimating()
            if isNetwork{
                if let err = error{
                    PopupHelper.showAlertControllerWithError(forErrorMessage: err, forViewController: self)
                }
                else{
                    if let dic = dataDict as? Dictionary<String,Any>{
                        switch action {
                        case .updateservice:
                            print(dataDict)
                            self.navigationController?.popToRootViewController(animated: true)
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
    @objc func logoutBtnPressed(_ sender:UIButton){
        let alertController = UIAlertController(title: "Oops!".localized(), message: "Are you sure want to logout?".localized(), preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No".localized(), style: .cancel) { action in
            
        }
        let yesAction = UIAlertAction(title: "Yes".localized(), style: .default) { action in
            self.logout()
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func deleteBarBtnPressed(_ sender:UIButton){
        PopupHelper.alertDeleteBarViewController(controler: self)
    }
    @objc func contactusBtnPressed(_ sender:UIButton){
        PopupHelper.alertContactusViewController(controler: self)
        
    }
    func logout(){
        FirebaseData.logout() //{ error in
//            let date = UserDefaults.standard.value(forKey: Constant.checkDate) as? Int64
//            let userid = UserDefaults.standard.value(forKey:Constant.user_id)
//            CommonHelper.removeCachedUserData()
//            UserDefaults.standard.set(true, forKey: Constant.isFirstTime)
//            UserDefaults.standard.set(date, forKey: Constant.checkDate)
//            UserDefaults.standard.set(userid, forKey: Constant.user_id)
//            if selftimer != nil{
//                selftimer.invalidate()
//                selftimer = nil
//            }
//            let dashboardViewController = self.storyboard?.instantiateViewController(identifier: "LGSideMenuController") as! LGSideMenuController
//            LangHelper.setLangauge(lang: Languages.es)
//            UIApplication.shared.windows.first?.rootViewController = dashboardViewController
//        }
        
    }
    func loadData(){
        PopupHelper.showAnimating(controler:self)
        FirebaseData.getUserData(uid: FirebaseData.getCurrentUserId().0) { error, userData in
            PopupHelper.stopAnimating(controler: self)
            if let error = error {
                //self.logout()
                return
            }
            guard let userData = userData else {
                //self.logout()
                return
            }
            self.userData = userData
            self.location.address_name = userData.baddress
            self.location.address_lat = userData.blat
            self.location.address_lng = userData.blng
            self.contactInfoArray.first?.value = userData.cname
            self.contactInfoArray.last?.value = userData.cphone
            self.barInfoArray.first?.value = userData.bname
            self.barInfoArray.last?.value = userData.baddress
            
            if let drinkArray = userData.barBottle{
                self.drinkPriceArray.forEach { drinkPrices1Model in
                    loop: for drinkPrices in drinkPrices1Model.drinks{
                        for var drinks in drinkArray{
                            if drinks.drinkName == drinkPrices.drinkName{
                                if drinks.drinkPrice != nil{
                                    drinks.drinkPrice?.forEach({ chr in
                                        if chr == ","{
                                            drinks.drinkPrice = drinks.drinkPrice?.replacingOccurrences(of: ",", with: ".")
                                        }
                                    })
                                }
                                drinkPrices.drinkPrice = drinks.drinkPrice
                            }
                            
                        }
                    }
                }
            }
            if let barHas = userData.barHas{
                for bar in barHas{
                    switch bar.title{
                    case "Terrace":
                        for my in self.myBarHasArray{
                            if bar.title == my.title{
                                my.isSelected = bar.isSelected
                            }
                        }
                    case "Rooftop":
                        for my in self.myBarHasArray{
                            if bar.title == my.title{
                                my.isSelected = bar.isSelected
                            }
                        }
                    default:
                        break
                    }
                }
                
            }
            var week = [WeekDayModel]()
            if let weeks = userData.barWeekDay{
                for wek in weeks{
                    week.append(wek)
                }
            }
            self.weekArray = week
            self.barSupliment.isSupliment = userData.isSupliment
            self.EditBarProfileTableView.reloadData()
        }
        
    }
    func deleteAccount(){
        PopupHelper.showAnimating(controler:self)
        var user = [String:Any]()
        user[UserKeys.id.rawValue] = self.userData.id
        self.callwebservice(user, action: .deleteaccount, method: .post)
    }
    func loadAddress(_ location:LocationModel){
        self.location = location
        let index = IndexPath(row: 1, section: 8)
        let cell = self.EditBarProfileTableView.cellForRow(at: index) as! ContactInfoTableViewCell
        cell.FieldTF.text = location.address_name
        self.barInfoArray[index.row].value = location.address_name
        //self.EditBarProfileTableView.reloadRows(at: [index], with: .automatic)
        
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
                        case .updatestore:
                            if let result = dic["result"] as? NSDictionary{
                                let user = UserModelW(dic: result)
                                CommonHelper.saveCachedUserData(user!)
                                self.delegate.loadData()
                                self.navigationController?.popViewController(animated: true)
                            }
                            else if let message = dic["message"] as? String{
                                PopupHelper.showAlertControllerWithError(forErrorMessage: message, forViewController: self)
                            }
                            
                        case .deleteaccount:
                            if let message = dic["msg"] as? String{
//                                let alertController = UIAlertController(title: "Succes", message: message, preferredStyle: .alert)
//                                let okAction = UIAlertAction(title: "Ok", style: .default) { action in
//                                    self.logout()
//                                }
//                                alertController.addAction(okAction)
//                                self.present(alertController, animated: true, completion: nil)
                                //self.logout()
                            }
                        case .getsingle:
                            if let result = dic["result"] as? NSDictionary{
                                self.updateBar()
                            }
                            else{
                                let alertController = UIAlertController(title: "Succes", message: "Your Account Deleted", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Ok", style: .default) { action in
                                    //self.logout()
                                }
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                            
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? LocationViewController{
            controller.delagate = self
        }
    }
    
}

//MARK:- HELPING METHOD'S
extension EditBarProfileViewController{
    
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
        headerTitle.font = UIFont(name: Constant.cabinFont, size: Constant.fontSize17)
        return headerTitle
    }
}

//MARK:- UITABLEVIEW DELEGATE AND DATASOURCE
extension EditBarProfileViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers_Array.count + self.drinkPriceArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerView = Bundle.main.loadNibNamed("ProfileHeader", owner: self, options: nil)?.first as! ProfileHeader
            headerView.HeaderLabel.text = "Edit Drinks".localized()
            headerView.backgroundColor = UIColor(named: "Background 4")
            //view.DescriptionLabel.text = self.descriptionArray.first
            return headerView
        case 1,2,3,4:
            let headerView = headerForTableView(tableView: tableView)
            let headerTitle = labelForTableViewHeader(headerView: headerView)
            headerTitle.text = ""
            headerView.addSubview(headerTitle)
            headerView.backgroundColor = UIColor(named: "Background 4")
            return headerView
        case 8:
            let headerView = Bundle.main.loadNibNamed("ContactInfoHeaderView", owner: self, options: nil)?.first as! ContactInfoHeaderView
            headerView.lblName.text = self.headers_Array[section - self.drinkPriceArray.count]
            headerView.lblDetail.text = ""
            headerView.backgroundColor = UIColor(named: "Background 4")
            return headerView
        case 9:
            let headerView = Bundle.main.loadNibNamed("ContactInfoHeaderView", owner: self, options: nil)?.first as! ContactInfoHeaderView
            headerView.lblName.text = self.headers_Array[section - self.drinkPriceArray.count]
            headerView.lblDetail.text = self.descriptionArray.last
            headerView.backgroundColor = UIColor(named: "Background 4")
            return headerView
        default:
            let headerView = headerForTableView(tableView: tableView)
            let headerTitle = labelForTableViewHeader(headerView: headerView)
            headerTitle.text = self.headers_Array[section - self.drinkPriceArray.count]
            headerView.addSubview(headerTitle)
            headerView.backgroundColor = UIColor(named: "Background 4")
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1,2,3,4:
            return 16
        case 8,9:
            return 50
        default:
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2,3:
            return self.drinkPriceArray[section].drinks.count
        case 5:
            return self.myBarHasArray.count
        case 7:
            return self.weekArray.count + 1
        case 8:
            return self.barInfoArray.count
        case 9:
            return self.contactInfoArray.count
        case 10:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,1,2,3: //MARK: DRINKS
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.drinksTableViewCell) as! DrinksTableViewCell
            cell.DrinkTitle.text = self.drinkPriceArray[indexPath.section].drinks[indexPath.row].drinkName.rawValue
            cell.DrinkImage.image = UIImage(named: self.drinkPriceArray[indexPath.section].drinks[indexPath.row].drinkImage)
            if let price = self.drinkPriceArray[indexPath.section].drinks[indexPath.row].drinkPrice{
                if price.contains("-"){
                    cell.DrinkPrice.text = "€"
                }
                else{
                    cell.DrinkPrice.text = "\(price)€"
                }
                
            }
            else{
                cell.DrinkPrice.text = nil
            }
            
            cell.DrinkPrice.tag = indexPath.row
            cell.DrinkPrice.accessibilityHint = "\(indexPath.section)"
            cell.DrinkPrice.delegate = self
            cell.DrinkPrice.keyboardType = .decimalPad
            cell.DrinkPrice.addTarget(self, action: #selector(self.priceTextFieldChanged(_:)), for: .editingChanged)
            return cell
        case 4: //MARK: BAR INFO IMAGE
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barInfoImageTableViewCell) as! BarInfoImageTableViewCell
//            cell.CaptureImage.image = barImage
//            if self.isImageEdited{
//                cell.BlurView.isHidden = true
//                cell.CaptureImage.image = barImage
//            }else{
//                cell.BlurView.isHidden = false
//                cell.BlurViewButton.addTarget(self, action: #selector(self.editImageBtnAction(_:)), for: .touchUpInside)
//                cell.CaptureImage.image = #imageLiteral(resourceName: "Image")
//            }
            let placeholder = #imageLiteral(resourceName: "Profile2")
            if let imagstr = self.userData.image{
                if self.isImageEdited{
                    cell.BlurView.isHidden = true
                    cell.CaptureImage.image = barImage
                }
                else{
                    if let url = URL(string: imagstr){
                        cell.CaptureImage.af.setImage(withURL: url, placeholderImage: placeholder, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false){data in
                            switch data.result{
                            case .success(let imag):
                                self.barImage = imag
                                cell.CaptureImage.image = imag
                            case .failure(let error):
                                print(error.localizedDescription)
                                cell.CaptureImage.image = self.barImage
                            }
                            
                            
                        }
                        cell.BlurView.isHidden = true
                    }
                    else{
                        cell.BlurView.isHidden = false
                        cell.CaptureImage.image = placeholder
                        cell.BlurViewButton.addTarget(self, action: #selector(self.editImageBtnAction(_:)), for: .touchUpInside)
                    }
                }
                
            }
            else{
                if self.isImageEdited{
                    cell.BlurView.isHidden = true
                    cell.CaptureImage.image = barImage
                }
                else{
                    cell.BlurView.isHidden = false
                    cell.CaptureImage.image = placeholder
                    cell.BlurViewButton.addTarget(self, action: #selector(self.editImageBtnAction(_:)), for: .touchUpInside)
                }
                
            }
            return cell
        case 5: //MARK: ONLY SHOW
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.onlyShowTableViewCell) as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.myBarHasArray[indexPath.row].title.localized()
            if self.myBarHasArray[indexPath.row].isSelected {
                cell.ImageLabel.image = #imageLiteral(resourceName: "Rectangle 71")
                cell.BackImage.image = UIImage(named: "Filter row selected")
                cell.TitleLabel.textColor = .white
            }else{
                cell.ImageLabel.image = #imageLiteral(resourceName: "Rectangle 711")
                cell.BackImage.image = UIImage(named: "")
                cell.TitleLabel.textColor = .black
            }
            return cell
        case 6: //MARK: SUPPLEMENT
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
               // else{
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
            
        case 7: //MARK: OPENING HOURS
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openHoursHeaderTableViewCell) as! OpenHoursHeaderTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openingHourTableViewCell) as! OpeningHourTableViewCell
                if self.weekArray[indexPath.row - 1].name == .none{
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
                if let week = self.weekArray[indexPath.row - 1].name{
                    cell.WeekNameLabel.text = week.localized()
                }
                else{
                    cell.WeekNameLabel.text = nil
                }
                cell.tfStartDate.keyboardType = .numberPad
                if let value = self.weekArray[indexPath.row - 1].svalue,value != 0 {
                    cell.tfStartDate.text = value.timestampToTimeString()
                }
                else{
                    cell.tfStartDate.text = nil
                }
                cell.tfStartDate.tag = indexPath.row
                cell.tfStartDate.accessibilityHint = "\(indexPath.section)"
                cell.tfStartDate.accessibilityValue = "s"
                cell.tfStartDate.delegate = self
                
                cell.tfEndDate.keyboardType = .numberPad
                if let value = self.weekArray[indexPath.row - 1].evalue,value != 0 {
                    cell.tfEndDate.text = value.timestampToTimeString()
                }
                else{
                    cell.tfEndDate.text = nil
                }
                cell.tfEndDate.tag = indexPath.row
                cell.tfEndDate.accessibilityHint = "\(indexPath.section)"
                cell.tfEndDate.accessibilityValue = "e"
                cell.tfEndDate.delegate = self
                return cell
            }
        case 8:  //MARK: BAR INFO
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.contactInfoTableViewCell) as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.barInfoArray[indexPath.row].name.localized()
            cell.TitleLabel.tag = indexPath.row
            cell.FieldTF.keyboardType = .default
            cell.FieldTF.placeholder = self.barInfoArray[indexPath.row].name.localized()
            cell.FieldTF.text = self.barInfoArray[indexPath.row].value
            cell.FieldTF.tag = indexPath.row
            cell.FieldTF.accessibilityHint = "\(indexPath.section)"
            cell.FieldTF.delegate = self
            return cell
        case 9: //MARK: ACCOUNT INFO
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.contactInfoTableViewCell) as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.contactInfoArray[indexPath.row].name.localized()
            cell.TitleLabel.tag = indexPath.row
            cell.FieldTF.keyboardType = self.contactInfoArray[indexPath.row].keyBoardType
            cell.FieldTF.isSecureTextEntry = self.contactInfoArray[indexPath.row].showText
            cell.FieldTF.placeholder = self.contactInfoArray[indexPath.row].name.localized()
            cell.FieldTF.text = self.contactInfoArray[indexPath.row].value
            cell.FieldTF.tag = indexPath.row
            cell.FieldTF.accessibilityHint = "\(indexPath.section)"
            cell.FieldTF.delegate = self
            return cell
        case 10: //MARK: LOGOUT
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.logoutBtn1TableViewCell) as! LogoutBtn1TableViewCell
                cell.LogoutBtn.addTarget(self, action: #selector(self.deleteBarBtnPressed(_:)), for: .touchUpInside)
                cell.LogoutBtn.setTitle("Delete bar".localized(), for: .normal)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.logoutBtn1TableViewCell) as! LogoutBtn1TableViewCell
                cell.LogoutBtn.addTarget(self, action: #selector(self.contactusBtnPressed(_:)), for: .touchUpInside)
                cell.LogoutBtn.setTitle("Contact us".localized(), for: .normal)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.logoutBtnTableViewCell) as! LogoutBtnTableViewCell
                cell.LogoutBtn.addTarget(self, action: #selector(self.logoutBtnPressed(_:)), for: .touchUpInside)
                return cell
            default:
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4{ //MARK: BAR INFO IMAGE
            //Open Camera
            self.CameraBottomSheet()
        }
        else
        if indexPath.section == 5{
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
            self.EditBarProfileTableView.reloadSections([5], with: .none)
        }
        else{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    @objc func priceTextFieldChanged( _ sender:UITextField){
        if var data = sender.text{
            data.removeAll(where: { chr in
                return chr == "€"
            })
            if !data.isEmpty{
                var countr = 0
                data.forEach { chr in
                    if chr == "."{
                        countr += 1
                    }
                    
                }
                if countr > 1{
                    data.removeAll(where: { chr in
                        return chr == "."
                    })
                    sender.text = "\(data).€"
                }
                else{
                    if data == "0" || data == "." || data == "0.0"{
                        sender.text = nil
                    }
                    else{
                        sender.text = "\(data)€"
                    }
                    
                }
                
                
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
        let section = Int(sender.accessibilityHint ?? "0")
        switch section {
        case 0,1,2,3:
            if var data = sender.text{
                data.removeAll { chr in
                    return chr == "€"
                }
                self.drinkPriceArray[section!].drinks[sender.tag].drinkPrice = data
            }
        default:
            break
        }
        
    }
    //EDIT IMAGE BUTTON ACTION
    @objc func editImageBtnAction( _ sender:UIButton){
        self.CameraBottomSheet()
    }
    @objc func termsOfUserAction(sender:UITapGestureRecognizer){
        let vc = self.getViewController(identifier: dataPolicyViewController) as! DataPolicyViewController
        vc.vcTitle = termsOfUseTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func dataPolicyAction(ssender:UITapGestureRecognizer){
        let vc = self.getViewController(identifier: dataPolicyViewController) as! DataPolicyViewController
        vc.vcTitle = dataPolicyTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func addTimeBtnPressed(_ sender:UIButton){
        self.weekArray.insert(WeekDayModel(weekDay: self.weekArray[sender.tag - 1].weekDay), at: sender.tag)
        self.EditBarProfileTableView.reloadSections([7], with: .none)
    }
    @objc func removeTimeBtnPressed(_ sender:UIButton){
        self.weekArray.remove(at: sender.tag - 1)
        self.EditBarProfileTableView.reloadSections([7], with: .none)
    }
    @objc func suplemntCheckBtnPressed(_ sender:UIButton){
        if self.barSupliment.isSupliment{
            self.barSupliment.isSupliment = false
            self.barSupliment.rate = nil
            self.barSupliment.type = nil
        }
        else{
            self.barSupliment.isSupliment = true
        }
        self.EditBarProfileTableView.reloadSections([6], with: .none)
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
extension EditBarProfileViewController {
    //BOTTOM SHEET WHICH WILL SHOW TWO OPTION [CAMERA AND GALLERY]
    func CameraBottomSheet() {
        let alert = UIAlertController(title: Constant.chooseImageTilte.localized(), message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constant.camera.localized(), style: .default, handler: { _ in
            self.Selected_choise(choise: Constant.camera.localized())
        }))
        
        alert.addAction(UIAlertAction(title: Constant.gallery.localized(), style: .default, handler: { _ in
            self.Selected_choise(choise: Constant.gallery.localized())
        }))
        
        alert.addAction(UIAlertAction.init(title: Constant.cancel.localized(), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    // THIS METHOD IS USE FOR CHOICE WHICH IS SELECTED BY USER
    func Selected_choise(choise:String){
        if choise == Constant.gallery.localized(){
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
        image.mediaTypes = [
            Constant.assetsTypeImage,
            Constant.assetsTypeMovie
        ]
    }
    // THIS METHOD WILL OPEN CAMERA FOR CAPTURING IMAGE
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }else {
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
        self.EditBarProfileTableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
        
    }
}

extension EditBarProfileViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch Int64(textField.accessibilityHint ?? "0") {
        case 8:
            
            if textField.tag == 1{
                textField.resignFirstResponder()
                self.performSegue(withIdentifier: "toLocate", sender: nil)
            }
        case 7:
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
            if filtr{
                //textField.resignFirstResponder()
                //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill top time first", forViewController: self)
            }
            if textField.accessibilityValue == "s"{
                //self.createPickerView(textField)
            }
            else if textField.accessibilityValue == "e"{
                //self.createPickerView(textField)
            }
        default:
            textField.becomeFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let section = Int(textField.accessibilityHint ?? "0")
        switch section {
        case 0,1,2,3:
            if var data = textField.text{
                data.removeAll { chr in
                    return chr == "€"
                }
                
                if data.last == "."{
                    data.append("0")
                    self.drinkPriceArray[section!].drinks[textField.tag].drinkPrice = data
                }
                else{
                    self.drinkPriceArray[section!].drinks[textField.tag].drinkPrice = data
                }
            }
            
            
            //self.barInfoArray[textField.tag].value = textField.text
        case 6:
            if textField.text!.isEmpty{
                self.barSupliment.isSupliment = true
                self.barSupliment.rate = nil
            }
            else{
                self.barSupliment.rate = textField.text!
                self.barSupliment.isSupliment = false
            }
            self.EditBarProfileTableView.reloadSections([6], with: .none)
        case 7:
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
                            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the top end time after", forViewController: self)
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
                               // //textField.text = nil
                               // //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
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
                            self.weekArray[textField.tag - 1].evalue = time
                            textField.text = timeformat
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
                        self.weekArray[textField.tag - 1].evalue = time
                        textField.text = timeformat
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
                                       // //textField.text = nil
                                       // //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                        self.weekArray[textField.tag - 1].evalue = time
                                    }
                                    else{
                                        self.weekArray[textField.tag - 1].evalue = time
                                    }
                                }
                                else{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                    self.weekArray[textField.tag - 1].evalue = time
                                }
                                
                                
                                
                            }
                            else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                if time <= s_time{
                                    ////textField.text = nil
                                   // //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                    self.weekArray[textField.tag - 1].evalue = time
                                }
                                else{
                                    self.weekArray[textField.tag - 1].evalue = time
                                }
                            }
                            else{
                                //textField.text = nil
                                //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                self.weekArray[textField.tag - 1].evalue = time
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
                                           ////textField.text = nil
                                            ////PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
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
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
                                    }
                                }
                                else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                    if time <= s_time{
                                        //textField.text = nil
                                        //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
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
                                       // //textField.text = nil
                                        ////PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after", forViewController: self)
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
                                    }
                                    else{
                                        self.weekArray[textField.tag - 1].evalue = time
                                        textField.text = timeformat
                                    }
                                }
                                else{
                                   // textField.text = nil
                                   // PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                    self.weekArray[textField.tag - 1].evalue = time
                                    textField.text = timeformat
                                }
                            }
                            else if let s_time = self.weekArray[textField.tag - 1].svalue{
                                if time <= s_time{
                                    //textField.text = nil
                                    //PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill correct time of the start time after".localized(), forViewController: self)
                                    self.weekArray[textField.tag - 1].evalue = time
                                    textField.text = timeformat
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
//            if textField.accessibilityValue == "s"{
//                if textField.text?.count == 2{
//                    self.weekArray[textField.tag - 1].svalue = "\(textField.text!):00".getTimeFromStringToDate().toMillisInt64()
//                    textField.text = "\(textField.text!):00"
//                }
//                else{
//                    self.weekArray[textField.tag - 1].svalue = textField.text!.getTimeFromStringToDate().toMillisInt64()
//                }
//
//            }
//            else if textField.accessibilityValue == "e"{
//                if textField.text?.count == 2{
//                    self.weekArray[textField.tag - 1].evalue = "\(textField.text!):00".getTimeFromStringToDate().toMillisInt64()
//                    textField.text = "\(textField.text!):00"
//                }
//                else{
//                    self.weekArray[textField.tag - 1].evalue = textField.text!.getTimeFromStringToDate().toMillisInt64()
//                }
//
//            }
        case 8:
            self.barInfoArray[textField.tag].value = textField.text
            
        case 9:
            self.contactInfoArray[textField.tag].value = textField.text
            //self.suplimentPercentage = textField.text!
        default:
            break
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch Int64(textField.accessibilityHint ?? "0") {
        case 0,1,2,3:
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
        case 7:
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
extension EditBarProfileViewController{
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
        if let cell = self.EditBarProfileTableView.cellForRow(at: IndexPath(row: mainPickerView.tag, section: 6)) as? OpeningHourTableViewCell{
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
