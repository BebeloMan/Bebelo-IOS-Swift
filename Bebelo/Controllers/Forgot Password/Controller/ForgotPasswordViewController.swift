//
//  ForgotPasswordViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit
class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var tfEmail:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sendBtnPressed(_ sender:Any){
    
        if self.tfEmail.text!.isEmpty {
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill email".localized(), forViewController: self)
            return
        }
        else if !self.tfEmail.text!.isValidEmail(){
            PopupHelper.showAlertControllerWithError(forErrorMessage: "Please fill valid email".localized(), forViewController: self)
            return
        }
        PopupHelper.showAnimating(controler:self)
        
    }
}
