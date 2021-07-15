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
    var delegate1:SelectedBarDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGuestureOnView()
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
            self.dismiss(animated: true) {
                DispatchQueue.main.async {
                    self.delegate1.dismiss(animated: true) {
                        if let control = self.delegate.tabBarController as? TabbarViewController{
                            control.selectedIndex = self.selectedIndex
                        }
                    }
                }
            }
        }
    }
}
