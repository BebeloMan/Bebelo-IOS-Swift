//
//  SelectedBarDetailViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 09/07/2021.
//

import UIKit

class SelectedBarDetailViewController: UIViewController {
    
    //IBOUTLET'S
    @IBOutlet weak var BarDetailTableView: UITableView!
    
    //VARIABLE'S
    let headers_Array = ["","","Cerveza"]
    let MainCategoryImages = ["Bombay-1","Bombay","image 4"]
    let MainCategoryTitle = ["Bombay Sapphire","Havanna Club","Jameson"]
    var delegate:MapViewController!
    var isPreviousClose = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        let yourBackImage = UIImage(named: "image 13")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = "Custom"
    }
    @IBAction func OptionBtnAction(_ sender: Any) {
        let optionView = self.getViewController(identifier: "MenuOptionViewController") as! MenuOptionViewController
        optionView.delegate = self
        self.present(optionView, animated: true, completion: nil)
    }
    @IBAction func CloseBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showfullviewAction(_ sender: Any) {
        if isPreviousClose == false{
            self.dismiss(animated: true) {
                self.delegate.showFullView()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SelectedBarProfileViewController{
            controller.delegate = self.delegate
        }
    }
    // Delegate methods which call My Bar Detail
    func bardeatail(){
        self.performSegue(withIdentifier: "ShowBar", sender: nil)
    }
}

//MARK:- HELPING METHOD'S
extension SelectedBarDetailViewController{
    func getViewController(identifier:String)-> UIViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: identifier)
        return vc
    }
}

//MARK:- UITABLEVIEW DELEGATES AND DATASOURCE METHOD'S
extension SelectedBarDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers_Array.count
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return self.headers_Array[section]
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .clear
        let label = UILabel()
        label.frame = CGRect.init(x: 21, y: 25.33, width: headerView.frame.width-20, height: headerView.frame.height-20)
        label.text = self.headers_Array[section]
        label.font = UIFont(name: "OpenSans-Bold", size: 15)
        label.textColor = UIColor(named: "Label Text")
        label.backgroundColor = .clear
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2{
            return 65
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return self.MainCategoryImages.count
        }else{
            return self.MainCategoryImages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BarDetailTableViewCell") as! BarDetailTableViewCell
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCategoryTableViewCell") as! MainCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
            cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherCategoryTableViewCell") as! OtherCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
            cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
            return cell
        }
    }
    
}
