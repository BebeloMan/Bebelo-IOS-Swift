//
//  ContactUsViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 22/09/2021.
//

import UIKit
import STPopup
class ContactUsViewController: UIViewController {

    
    var delegate:UIViewController!
    var popup = STPopupController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popup.backgroundView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismis)))
    }
    @objc func dismis(){
        self.dismiss()
    }
    
    func dismiss(){
        
        self.popup.dismiss {

        }
    }
    @IBAction func closeBtnPressed(_ sender:Any){
        self.dismiss()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
