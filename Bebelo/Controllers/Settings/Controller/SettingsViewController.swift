//
//  SettingsViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/07/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //VARIABLE'S
    let headers_Array = ["","Bar profile","Only show","Community","The boring stuff"]
    let onlyShowArray = ["Terraces", "Rooftops"]
    let theBorringStuffArray = ["Terms of use", "Data policy"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.headers_Array.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headers_Array[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 20
        }else{
            return 65
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return self.onlyShowArray.count
        }else if section == 3{
            return 1
        }else{
            return self.theBorringStuffArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddBarTableViewCell") as! AddBarTableViewCell
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnlyShowTableViewCell") as! OnlyShowTableViewCell
            cell.TitleLabel.text = self.onlyShowArray[indexPath.row]
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell") as! CommunityTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BorringStuffTableViewCell") as! BorringStuffTableViewCell
            cell.TitleLabel.text = self.theBorringStuffArray[indexPath.row]
            return cell
        }
    }
}
