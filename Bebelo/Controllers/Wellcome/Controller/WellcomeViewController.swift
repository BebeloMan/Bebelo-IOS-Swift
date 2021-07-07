//
//  WellcomeViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit

class WellcomeViewController: UIViewController {
    //IBOUTLET'S
    @IBOutlet weak var MaleBtn: UIButton!
    @IBOutlet weak var FemaleBtn: UIButton!
    @IBOutlet weak var DayTF: UITextField!
    @IBOutlet weak var MonthTF: UITextField!
    @IBOutlet weak var YearTF: UITextField!
    
    //VARIABLE'S
    var isGenderSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //IBACTION'S
    @IBAction func MaleBtnAction(_ sender: Any) {
        self.changeGenderBtnBorder(type: true)
    }
    @IBAction func FemaleBtnAction(_ sender: Any) {
        self.changeGenderBtnBorder(type: false)
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
        
    }
    
    func changeGenderBtnBorder(type:Bool) {
        self.isGenderSelected = true
        if type{ //MALE
            self.MaleBtn.borderColor = UIColor(named: "Button Border")
            self.FemaleBtn.borderColor = UIColor(named: "Textfield Placeholder")
        }else{// FEMALE
            self.MaleBtn.borderColor = UIColor(named: "Textfield Placeholder")
            self.FemaleBtn.borderColor = UIColor(named: "Button Border")

        }
    }
}

// MARK: HELPING METHOD'S
extension WellcomeViewController{
    /*THIS METHOS WILL SETUP USER INTERFACE INITIAL SETTINGS*/
    func ValidateDate() -> Bool{
        if self.DayTF.text != " " || self.DayTF.text != "", self.MonthTF.text != " " || self.MonthTF.text != "",self.YearTF.text != " " || self.YearTF.text != ""{
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
