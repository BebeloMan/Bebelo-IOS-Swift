//
//  AnnouncementPopupViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit

class AnnouncementPopupViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var AnnouncementTextView: UITextView!
    
    // VARIABALE'S
    var delegate:AnnouncementProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AnnouncementTextView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //IBACTION'S
    @IBAction func AddButtonAction(_ sender: Any) {
        self.delegate?.AnnouncementDeletegate(announce: self.AnnouncementTextView.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- UITEXTVIEW DELEGATE METHOD'S
extension AnnouncementPopupViewController:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count < 51
    }
}
