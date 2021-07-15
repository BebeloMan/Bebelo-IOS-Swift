//
//  MenuOptionViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 12/07/2021.
//

import UIKit

class MenuOptionViewController: UIViewController {
    
    // IBOUTLET'S
    @IBOutlet weak var FlagImage: UIImageView!
    @IBOutlet weak var IsThisYourBarBackView: UIView!
    @IBOutlet weak var FlagBackView: UIView!
    
    //VARIABLE'S
    let unFlag = "image 56"
    let flag = "image 70"
    var isFlagSelected = false
    var delegate:SelectedBarDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(IsThisYourBarAction(_:)))
        
        IsThisYourBarBackView.addGestureRecognizer(viewTap)
        
        let flagTap = UITapGestureRecognizer(target: self, action: #selector(FlagAction(_:)))
        FlagBackView.addGestureRecognizer(flagTap)
    }
    
    //IBOUTLET'S
    @IBAction func CloseBtnAction(_ sender: Any) {
        self.dismiss(animated: true){
            
        }
    }
 
}

//MARK:- HELPING METHOD'S
extension MenuOptionViewController{
    
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: Constant.mainStoryboard, bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
    
    @objc func IsThisYourBarAction(_:UITapGestureRecognizer){
        self.dismiss(animated: true){
            self.delegate.bardeatail()
        }
    }
    
    @objc func FlagAction(_:UITapGestureRecognizer){
        // Move to next screen
        if isFlagSelected{
            isFlagSelected = false
            self.FlagImage.image = UIImage(named: unFlag)
        }else{
            isFlagSelected = true
            self.FlagImage.image = UIImage(named: flag)
        }
    }
}
