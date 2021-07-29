//
//  ShowTimingViewController.swift
//  Bebelo
//
//  Created by Buzzware Tech on 15/09/2021.
//

import UIKit
import STPopup
class ShowTimingViewController: UIViewController {

    @IBOutlet weak var BarTimingTableView: UITableView!
    var delegate:UIViewController!
    var popup = STPopupController()
    var barData:UserModel!
    var weekArray = [WeekDayModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let controler = delegate as? MapViewController{
            self.barData = controler.selectedBar
        }
        if let bar = self.barData.barWeekDay{
            for bars in bar{
                
                weekArray.append(bars)
            }
            self.BarTimingTableView.reloadData()
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popup.backgroundView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismis)))
    }
    @objc func dismis(){
        self.dismiss()
    }
    
    func dismiss(){
        
        self.popup.dismiss {

        }
    }
    @IBAction func closeBtnPressed(_ sender:Any){
        self.dismiss()
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
extension ShowTimingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weekArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell.tfStartDate.placeholder = "00:00"
        if let svalue = self.weekArray[indexPath.row].svalue, svalue != 0,let evalue = self.weekArray[indexPath.row].evalue, evalue != 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.openingHourTableViewCell) as! OpeningHourTableViewCell
            if let name = self.weekArray[indexPath.row].name{
                cell.WeekNameLabel.text = name.localized()
            }
            else{
                cell.WeekNameLabel.text = nil
            }
            var time = svalue.timestampToTimeString()
//            if time!.contains("00:"){
//                time = time?.replacingOccurrences(of: "00:", with: "24:")
//            }
            cell.tfStartDate.text = time
            cell.tfStartDate.isUserInteractionEnabled = false
            
            //cell.tfEndDate.placeholder = "00:00"
            if let value = self.weekArray[indexPath.row].evalue,value != 0 {
                var time = value.timestampToTimeString()
//                if time!.contains("00:"){
//                    time = time?.replacingOccurrences(of: "00:", with: "24:")
//                }
                cell.tfEndDate.text = time
                
            }
            else{
                cell.tfEndDate.text = " "
            }
            cell.tfEndDate.isUserInteractionEnabled = false
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedHourTableViewCell") as! ClosedHourTableViewCell
            if let name = self.weekArray[indexPath.row].name{
                cell.WeekNameLabel.text = name.localized()
            }
            else{
                cell.WeekNameLabel.text = nil
            }
            cell.tfStartDate.isUserInteractionEnabled = false
            cell.tfStartDate.text = "Closed".localized()
            return cell
            
        }
        
        
    }
}
