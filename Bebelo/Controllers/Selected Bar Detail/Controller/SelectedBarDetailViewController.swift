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
        self.present(optionView, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headers_Array[section]
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainCategoryTableViewCell") as! MainCategoryTableViewCell
            cell.ProductImage.image = UIImage(named: self.MainCategoryImages[indexPath.row])
            cell.ProductNameLabel.text = self.MainCategoryTitle[indexPath.row]
            return cell
        }
    }
    
}
