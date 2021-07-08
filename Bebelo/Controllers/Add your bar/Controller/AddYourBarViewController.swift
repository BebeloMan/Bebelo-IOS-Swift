//
//  AddYourBarViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 07/07/2021.
//

import UIKit
import SDWebImage

class AddYourBarViewController: UIViewController {
    //IBOUTLET'S
    @IBOutlet weak var AddBarTableView: UITableView!
    
    //VARIABLE'S
    let headers_Array = ["Contact info","Bar info","","My bar has","","Account",""]
    let contactInfoArray = ["Your name","Phone no."]
    let barInfoArray = ["Bar name","Address"]
    let weekArray = ["","Monday","Tuesday","Wednesday","Thusday","Friday","Saturday","Sunday"]
    let myBarHasArray = ["Terraces", "Rooftops"]
    let accountArray = ["Email","Password"]
    let image = UIImagePickerController()
    var barImage = #imageLiteral(resourceName: "Group 97")
    var isImageEdited = false
    var delegate:PassDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func DoneBtnAction(_ sender: Any) {
        delegate?.doneBtnDelegate()
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- HELPING METHOD'S
extension AddYourBarViewController{
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
}

//MARK:- UITABLEVIEW DELEGATE AND DATASOURCE
extension AddYourBarViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers_Array.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headers_Array[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2{
            return 10
        }else if section == 4{
            return 10
        }else if section == 6{
            return 16
        }else{
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.contactInfoArray.count
        }else if section == 1{
            return self.barInfoArray.count
        }else if section == 2{
            return 1
        }else if section == 3{
            return self.myBarHasArray.count
        }else if section == 4{
            return self.weekArray.count
        }else if section == 5{
            return self.accountArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{//MARK: CONTACT INFO
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactInfoTableViewCell") as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.contactInfoArray[indexPath.row]
            cell.FieldTF.placeholder = self.contactInfoArray[indexPath.row]
            return cell
        }else if indexPath.section == 1{//MARK: BAR INFO
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactInfoTableViewCell") as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.barInfoArray[indexPath.row]
            cell.TitleLabel.tag = indexPath.row
            cell.FieldTF.placeholder = self.barInfoArray[indexPath.row]
            cell.FieldTF.tag = indexPath.row
            return cell
        }else if indexPath.section == 2{ //MARK: BAR INFO IMAGE
            let cell = tableView.dequeueReusableCell(withIdentifier: "BarInfoImageTableViewCell") as! BarInfoImageTableViewCell
            cell.CaptureImage.image = self.barImage
            if self.isImageEdited{
                cell.EditImageBtn.isHidden = false
                cell.EditImageBtn.addTarget(self, action: #selector(self.editImageBtnAction(_:)), for: .touchUpInside)
            }else{
                cell.EditImageBtn.isHidden = true
            }
            return cell
        }else if indexPath.section == 3{ //MARK: ONLY SHOW
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyShowTableViewCell") as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.myBarHasArray[indexPath.row]
            if indexPath.row == 0{
                cell.BackImage.image = UIImage(named: "Filter row selected")
                cell.ImageLabel.image = UIImage(named: "image 38")
            }else{
                cell.BackImage.image = UIImage(named: "")
                cell.ImageLabel.image = UIImage(named: "")
            }
            return cell
        }else if indexPath.section == 4{ //MARK: OPENING HOURS
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OpenHoursHeaderTableViewCell") as! OpenHoursHeaderTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OpeningHourTableViewCell") as! OpeningHourTableViewCell
                cell.WeekNameLabel.text = self.weekArray[indexPath.row]
                return cell
            }
        }else if indexPath.section == 5{ //MARK: ACCOUNT
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactInfoTableViewCell") as! ContactInfoTableViewCell
            cell.TitleLabel.text = self.accountArray[indexPath.row]
            cell.TitleLabel.tag = indexPath.row
            cell.FieldTF.placeholder = self.accountArray[indexPath.row]
            cell.FieldTF.tag = indexPath.row
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TermsAndConditionTableViewCell") as! TermsAndConditionTableViewCell
            let termsGusture = UITapGestureRecognizer(target: self, action: #selector(self.termsOfUserAction(sender:)))
            cell.TermsOfUseLabel.addGestureRecognizer(termsGusture)
            cell.TermsOfUseLabel.isUserInteractionEnabled = true
            let policyGusture = UITapGestureRecognizer(target: self, action: #selector(self.dataPolicyAction(ssender:)))
            cell.DataPolicyLabel.addGestureRecognizer(policyGusture)
            cell.DataPolicyLabel.isUserInteractionEnabled = true
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
        let vc = self.getViewController(identifier: "DataPolicyViewController") as! DataPolicyViewController
        vc.vcTitle = "Terms Of Use"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func dataPolicyAction(ssender:UITapGestureRecognizer){
        let vc = self.getViewController(identifier: "DataPolicyViewController") as! DataPolicyViewController
        vc.vcTitle = "Data Policy"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- CAMERA METHIO'S EXTENSION
extension AddYourBarViewController {
    //BOTTOM SHEET WHICH WILL SHOW TWO OPTION [CAMERA AND GALLERY]
    func CameraBottomSheet() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.Selected_choise(choise: "Camera")
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.Selected_choise(choise: "gallery")
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
        self.AddBarTableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}

