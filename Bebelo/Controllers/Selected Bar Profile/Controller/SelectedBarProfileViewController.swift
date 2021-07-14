//
//  SelectedBarProfileViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 12/07/2021.
//

import UIKit

class SelectedBarProfileViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    var delegate:MapViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapGuesture(_:)))
        backView.addGestureRecognizer(viewTap)
        // Do any additional setup after loading the view.
    }
    @objc func viewTapGuesture(_ sender: UITapGestureRecognizer){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

}
