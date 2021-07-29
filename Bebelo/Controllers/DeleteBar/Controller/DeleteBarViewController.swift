//
//  DeleteBarViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 22/09/2021.
//

import UIKit
import STPopup
class DeleteBarViewController: UIViewController {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    var delegate:UIViewController!
    var popup = STPopupController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popup.backgroundView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismis)))
    }
    @objc func dismis(){
        self.dismisss()
    }
    
    func dismisss(){
        
        self.popup.dismiss {
            
        }
    }
    @IBAction func closeBtnPressed(_ sender:Any){
        self.dismisss()
    }
    @IBAction func deleteBtnPressed(_ sender:Any){
        self.popup.dismiss {
            if let controler = self.delegate as? EditBarProfileViewController{
                controler.deleteAccount()
            }
        }
        
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
