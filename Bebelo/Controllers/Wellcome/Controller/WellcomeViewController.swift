//
//  WellcomeViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit

class WellcomeViewController: UIViewController {
    //IBOUTLET'S
    @IBOutlet weak var FieldsBorder: UIView!
    @IBOutlet weak var MaleBtn: UIButton!
    @IBOutlet weak var FemaleBtn: UIButton!
    @IBOutlet weak var DayTF: UITextField!
    @IBOutlet weak var MonthTF: UITextField!
    @IBOutlet weak var YearTF: UITextField!
    @IBOutlet weak var EnterBtn: UIButton!
    
    //VARIABLE'S
    var isGenderSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIInitialSetting()
        // Do any additional setup after loading the view.
    }
    
    //IBACTION'S
    @IBAction func MaleBtnAction(_ sender: Any) {
        changeGenderBtnBorder(type: true)
    }
    @IBAction func FemaleBtnAction(_ sender: Any) {
        changeGenderBtnBorder(type: false)
    }
    @IBAction func EnterBtnAction(_ sender: Any) {
        
        if self.ValidateDate(){
            PopupHelper.changeRootView(storyboardName: "Main", ViewControllerId: "TabbarController")
        }else{
            PopupHelper.alertWithOk(title: "Data not provided", message: "Date of birth and gender is not selected please provide date of birth and select gender", controler: self)
        }
    }
}

// MARK:- INITIAL SETTING OF USER INTERFACE (UI)
extension WellcomeViewController{
    /*THIS METHOS WILL SETUP USER INTERFACE INITIAL SETTINGS*/
    func setupUIInitialSetting() {
        DayTF.delegate = self
    }
    
    func changeGenderBtnBorder(type:Bool) {
        EnterBtn.backgroundColor = UIColor(named: "Button Background")
        self.isGenderSelected = true
        if type{ //MALE
            MaleBtn.borderColor = UIColor(named: "Button Border")
            FemaleBtn.borderColor = UIColor(named: "Textfield Placeholder")
        }else{// FEMALE
            MaleBtn.borderColor = UIColor(named: "Textfield Placeholder")
            FemaleBtn.borderColor = UIColor(named: "Button Border")
            
        }
    }
}

//MARK:- UITEXTFIELD DELEGATE METHOD'S
extension WellcomeViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count > 0{
            FieldsBorder.borderColor = UIColor(named: "Label Text 2")
        }else{
            FieldsBorder.borderColor = UIColor(named: "Textfield Placeholder")
        }
        return true
    }
}

// MARK: HELPING METHOD'S
extension WellcomeViewController{
    /*THIS METHOS WILL SETUP USER INTERFACE INITIAL SETTINGS*/
    func ValidateDate() -> Bool{
        if DayTF.text != " " || DayTF.text != "", MonthTF.text != " " || MonthTF.text != "",YearTF.text != " " || YearTF.text != ""{
            if isGenderSelected{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
}
