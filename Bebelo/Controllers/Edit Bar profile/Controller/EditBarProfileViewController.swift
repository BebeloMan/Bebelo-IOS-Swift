//
//  EditBarProfileViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit

class EditBarProfileViewController: UIViewController {
    
    @IBOutlet weak var EditBarProfileTableView: UITableView!
    
    //VARIABLE'S
    let headers_Array = [
        "Edit Drink",
        "",
        "",
        "My bar has",
        "",
        "Bar info",
        "Contact info"
    ]
    let drinksOneArray = [
        "Canna",
        "Doble"
    ]
    let drinkOneImageArray = [
        "image 60-1",
        "image 60-1"
    ]
    let drinksTwoArray = [
        "Bombay Sapphire",
        "Havana Club",
        "Jameson",
        "Brugal Anejo"
    ]
    let drinkTwoImageArray = [
        "Bombay-1",
        "Bombay",
        "image 4",
        "image 60"
    ]
    let contactInfoArray = [
        "Your name",
        "Phone no."
    ]
    let barInfoArray = [
        "Bar name",
        "Address"
    ]
    let weekArray = [
        "",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thusday",
        "Friday",
        "Saturday",
        "Sunday"
    ]
    let myBarHasArray = [
        "Terrace",
        "Rooftop"
    ]
    let accountArray = [
        "Email",
        "Password"
    ]
    
    let image = UIImagePickerController()
    let filterRowImage = "Filter row selected"
    let markImage = "image 38"
    let dataPolicyViewController = "DataPolicyViewController"
    let termsOfUseTitle = "Terms Of Use"
    let dataPolicyTitle = "Data Policy"
    var barImage = #imageLiteral(resourceName: "Group 97")
    var isImageEdited = false
    var delegate:PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //IBACTION'S
    @IBAction func DoneBtnAction(_ sender: Any) {
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
        headerTitle.font = UIFont(name: Constant.openSansFont, size: Constant.fontSize)
        return headerTitle
    }
}

//MARK:- UITABLEVIEW DELEGATE AND DATASOURCE
extension EditBarProfileViewController:UITableViewDelegate,UITableViewDataSource{
    
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
        if section == 1{
            return 16
        }else if section == 4{
            return 15
        }else{
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.drinksOneArray.count
        }else if section == 1{
            return self.drinksTwoArray.count
        }else if section == 2{
            return 1
        }else if section == 3{
            return self.myBarHasArray.count
        }else if section == 4{
            return self.weekArray.count
        }else if section == 5{
            return self.accountArray.count
        }else{
            return self.contactInfoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{//MARK: EDIT DRINKS
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.drinksTableViewCell) as! DrinksTableViewCell
            cell.DrinkTitle.text = self.drinksOneArray[indexPath.row]
            cell.DrinkImage.image = UIImage(named: self.drinkOneImageArray[indexPath.row])
            return cell
        }else if indexPath.section == 1{//MARK: EDIT DRINKS
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.drinksTableViewCell) as! DrinksTableViewCell
            cell.DrinkTitle.text = self.drinksTwoArray[indexPath.row]
            cell.DrinkImage.image = UIImage(named: self.drinkTwoImageArray[indexPath.row])
            return cell
        }else if indexPath.section == 2{ //MARK: BAR INFO IMAGE
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.barInfoImageTableViewCell) as! BarInfoImageTableViewCell
            cell.CaptureImage.image = barImage
            if self.isImageEdited{
                cell.BlurView.isHidden = true
                cell.CaptureImage.image = barImage
            }else{
                cell.BlurView.isHidden = false
                cell.BlurViewButton.addTarget(self, action: #selector(self.editImageBtnAction(_:)), for: .touchUpInside)
                cell.CaptureImage.image = #imageLiteral(resourceName: "image 18")
            }
            return cell
        }else if indexPath.section == 3{ //MARK: ONLY SHOW
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.onlyShowTableViewCell) as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.myBarHasArray[indexPath.row]
            if indexPath.row == 0{
                cell.BackImage.image = UIImage(named: filterRowImage)
                cell.ImageLabel.image = UIImage(named: markImage)
            }else{
                cell.BackImage.image = UIImage(named: "")
                cell.ImageLabel.image = UIImage(named: "")
            }
            return cell
        }else if indexPath.section == 4{ //MARK: OPENING HOURS
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openHoursHeaderTableViewCell) as! OpenHoursHeaderTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openingHourTableViewCell) as! OpeningHourTableViewCell
                cell.WeekNameLabel.text = self.weekArray[indexPath.row]
                return cell
            }
        }else if indexPath.section == 5{ //MARK: ACCOUNT
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.contactInfoTableViewCell) as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.barInfoArray[indexPath.row]
            cell.FieldTF.placeholder = self.barInfoArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.contactInfoTableViewCell) as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.contactInfoArray[indexPath.row]
            cell.FieldTF.placeholder = self.contactInfoArray[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{ //MARK: BAR INFO IMAGE
            //Open Camera
            self.CameraBottomSheet()
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
}


//MARK:- CAMERA METHIO'S EXTENSION
extension EditBarProfileViewController {
    //BOTTOM SHEET WHICH WILL SHOW TWO OPTION [CAMERA AND GALLERY]
    func CameraBottomSheet() {
        let alert = UIAlertController(title: Constant.chooseImageTilte, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constant.camera, style: .default, handler: { _ in
            self.Selected_choise(choise: Constant.camera)
        }))
        
        alert.addAction(UIAlertAction(title: Constant.gallery, style: .default, handler: { _ in
            self.Selected_choise(choise: Constant.gallery)
        }))
        
        alert.addAction(UIAlertAction.init(title: Constant.cancel, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    // THIS METHOD IS USE FOR CHOICE WHICH IS SELECTED BY USER
    func Selected_choise(choise:String){
        if choise == Constant.gallery{
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

