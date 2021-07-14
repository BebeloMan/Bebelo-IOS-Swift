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
    var isFlagSelected = false
    var delegate:SelectedBarDetailViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(IsThisYourBarAction(_:)))
        
        IsThisYourBarBackView.addGestureRecognizer(viewTap)
        
        let flagTap = UITapGestureRecognizer(target: self, action: #selector(FlagAction(_:)))
        FlagBackView.addGestureRecognizer(flagTap)
    }
    
    @IBAction func CloseBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func IsThisYourBarAction(_:UITapGestureRecognizer){
        // Move to next screen
        let BarProfile = self.getViewController(identifier: "SelectedBarProfileViewController") as! SelectedBarProfileViewController
        
        self.performSegue(withIdentifier: "ShowBar", sender: nil)
        
        //present(BarProfile, animated: true, completion: nil)
    }
    @objc func FlagAction(_:UITapGestureRecognizer){
        // Move to next screen
        if isFlagSelected{
            isFlagSelected = false
            self.FlagImage.image = UIImage(named: "image 56")
        }else{
            isFlagSelected = true
            self.FlagImage.image = UIImage(named: "image 70")
        }
    }
    
}

//MARK:- HELPING METHOD'S
extension MenuOptionViewController{
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
}
