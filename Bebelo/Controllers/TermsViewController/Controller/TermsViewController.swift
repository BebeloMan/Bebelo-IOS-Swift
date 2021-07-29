//
//  TermsViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 18/02/2022.
//

import UIKit
import PDFKit
class TermsViewController: UIViewController {

    @IBOutlet weak var pdfView:PDFView!
    //@IBOutlet weak var tvDetail:UITextView_Additions!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loadFile()
    }
    func loadFile(){
        //self.tvDetail.text = ""
        if let file = Bundle.main.url(forResource: "bebelo_policy", withExtension: "pdf"){
            if let doc = PDFDocument(url: file){
                
                self.pdfView.document = doc
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
