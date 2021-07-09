//
//  LoginViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 08/07/2021.
//

import UIKit

class LoginViewController: UIViewController {
    //IBOUTLET'S
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //IBACTION'S
    @IBAction func LoginButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddItHereBtnAction(_ sender: Any) {
        let vc = self.getViewController(identifier: "AddYourBarViewController") as! AddYourBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ForgotPasswordBtnAction(_ sender: Any) {
        let vc = self.getViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK:- HELPING METHOD'S
extension LoginViewController{
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
}
