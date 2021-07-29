//
//  SelectedBarProfileViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 12/07/2021.
//

import UIKit

class SelectedBarProfileViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var backView: UIView!
    
    //VARIABLE'S
    let selectedIndex = 1
    
    var delegate:MapViewController!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGuestureOnView()
    }
    @IBAction func BackBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- HELPING METHOD'S
extension SelectedBarProfileViewController{
    
    func addTapGuestureOnView() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapGuesture(_:)))
        backView.addGestureRecognizer(viewTap)
    }
    
    @objc func viewTapGuesture(_ sender: UITapGestureRecognizer){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.tabSettingBtnPressed([])
        }
    }
}
