//
//  perm.swift
//  Prosperity Financial
//
//  Created by Buzzware Tech on 27/05/2021.
//

import Foundation
enum UserKeys:String,CaseIterable {
    case userName = "userName"
    case phoneNumber = "phoneNumber"
    case email = "email"
    case password = "password"
    case token = "token"
    case id = "id"
    case cname = "cname"
    case cemail = "cemail"
    case cpassword = "cpassword"
    case cphone = "cphone"
    case bname = "bname"
    case baddress = "baddress"
    case blat = "blat"
    case blng = "blng"
    case image = "image"
    case imge_url = "imge_url"
    case bdetail = "bdetail"
    case status = "status"
    case barbottle_size = "barbottle_size"
    case drinkImage = "drinkImage"
    case drinkName = "drinkName"
    case drinkPrice = "drinkPrice"
    case Terraces = "Terraces"
    case Rooftops = "Rooftops"
    case barSupliment = "barSupliment"
    case barAnounce_date = "barAnounce_date"
    case barAnounce_data = "barAnounce_data"
    case freeTable_date = "freeTable_date"
    case freeTable_freeTable = "freeTable_freeTable"
    case weekday_size = "weekday_size"
    case weekDay = "weekDay"
    case _sValue = "_sValue"
    case _eValue = "_eValue"
    case count = "count"
    case distanceflag = "distanceflag"
    
}
class LoginModel: Codable {
    
    var id: String!
    var email:String!
    var imageURL:String!
    var latitude:String!
    var location:String!
    var longitude:String!
    var name:String!
    var number:String!
    var password:String!
    var country:String!
    
    init(id:String? = nil,email: String? = nil,imageURL: String? = nil,latitude: String? = nil,location: String? = nil,longitude:String? = nil,name: String? = nil,number:String? = nil,password:String? = nil,country:String? = nil) {
        self.id = id
        self.email = email
        self.imageURL = imageURL
        self.latitude = latitude
        self.location = location
        self.longitude = longitude
        self.name = name
        self.number = number
        self.password = password
        self.country = country
    }
    
    init?(dic:NSDictionary) {
        
        let id = (dic as AnyObject).value(forKey: Constant.id) as? String
        let email = (dic as AnyObject).value(forKey: Constant.email) as! String
        let imageURL = (dic as AnyObject).value(forKey: Constant.imageURL) as? String
        let latitude = (dic as AnyObject).value(forKey: Constant.latitude) as? String
        let location = (dic as AnyObject).value(forKey: Constant.location) as? String
        let longitude = (dic as AnyObject).value(forKey: Constant.longitude) as? String
        let name = (dic as AnyObject).value(forKey: Constant.name) as? String
        let number = (dic as AnyObject).value(forKey: Constant.number) as? String
        let password = (dic as AnyObject).value(forKey: Constant.password) as? String
        let country = (dic as AnyObject).value(forKey: Constant.country) as? String
        
        self.id = id
        self.email = email
        self.imageURL = imageURL
        self.latitude = latitude
        self.location = location
        self.longitude = longitude
        self.name = name
        self.number = number
        self.password = password
        self.country = country
        
    }
}
class UserModelW:Codable {
    
    var id: String!
    var cname:String!
    var cemail:String!
    var cpassword:String!
    var cphone:String!
    var bname:String!
    var baddress:String!
    var blat:String!
    var blng:String!
    var imge_url:String!
    var bdetail:String!
    var status:String!
    var distanceflag:Bool!
    
    init(id:String? = nil,cname: String? = nil,cemail: String? = nil,cpassword: String? = nil,cphone: String? = nil,bname:String? = nil,baddress: String? = nil,blat:String? = nil,blng:String? = nil,imge_url:String? = nil,bdetail:String? = nil,status:String? = nil,distanceflag:Bool = false) {
        self.id = id
        self.cname = cname
        self.cemail = cemail
        self.cpassword = cpassword
        self.cphone = cphone
        self.bname = bname
        self.baddress = baddress
        self.blat = blat
        self.blng = blng
        self.imge_url = imge_url
        self.bdetail = bdetail
        self.status = status
        self.distanceflag = distanceflag
    }
    
    init?(dic:NSDictionary) {
        
        let id = (dic as AnyObject).value(forKey: UserKeys.id.rawValue) as? String
        let cname = (dic as AnyObject).value(forKey: UserKeys.cname.rawValue) as? String
        let cemail = (dic as AnyObject).value(forKey: UserKeys.cemail.rawValue) as? String
        let cpassword = (dic as AnyObject).value(forKey: UserKeys.cpassword.rawValue) as? String
        let cphone = (dic as AnyObject).value(forKey: UserKeys.cphone.rawValue) as? String
        let bname = (dic as AnyObject).value(forKey: UserKeys.bname.rawValue) as? String
        let baddress = (dic as AnyObject).value(forKey: UserKeys.baddress.rawValue) as? String
        let blat = (dic as AnyObject).value(forKey: UserKeys.blat.rawValue) as? String
        let blng = (dic as AnyObject).value(forKey: UserKeys.blng.rawValue) as? String
        let imge_url = (dic as AnyObject).value(forKey: UserKeys.imge_url.rawValue) as? String
        let bdetail = (dic as AnyObject).value(forKey: UserKeys.bdetail.rawValue) as? String
        let status = (dic as AnyObject).value(forKey: UserKeys.status.rawValue) as? String
        let distanceflag = (dic as AnyObject).value(forKey: UserKeys.distanceflag.rawValue) as? Bool
        
        self.id = id
        self.cname = cname
        self.cemail = cemail
        self.cpassword = cpassword
        self.cphone = cphone
        self.bname = bname
        self.baddress = baddress
        self.blat = blat
        self.blng = blng
        self.imge_url = imge_url
        self.bdetail = bdetail
        self.status = status
        if distanceflag == nil{
            self.distanceflag = false
        }
        else{
            self.distanceflag = distanceflag
        }
        
        
    }
}
enum BarKeys:String{
    case barId = "barId"
    case userId = "userId"
    case barName = "barName"
    case imageUrl = "imageUrl"
    case barAddress = "barAddress"
    case barLat = "barLat"
    case barLng = "barLng"
    case barBottle = "barBottle"
    case barWeekDay = "barWeekDay"
    case barHas = "barHas"
    case barSupliment = "barSupliment"
    case barAnounce = "barAnounce"
    case freeTable = "freeTable"

}
class BarModelW:Codable {
    
    var barBottle: [DrinkPricesModelW]!
    var barWeekDay:[WeekDayModelW]!
    var barHas:[OnlyShowModelW]!
    var barSupliment:SuplimentModelW!
    var barAnounce:AnnounceModelW!
    var freeTable:FreeTableModelW!
    var cemail:String!
    var updated:Bool!
    
    init(barBottle:[DrinkPricesModelW]? = nil,barWeekDay: [WeekDayModelW]? = nil,barHas: [OnlyShowModelW]? = nil,barSupliment: SuplimentModelW? = nil,barAnounce: AnnounceModelW? = nil,freeTable:FreeTableModelW? = nil,cemail:String? = nil,updated:Bool = false) {
        self.barBottle = barBottle
        self.barWeekDay = barWeekDay
        self.barHas = barHas
        self.barSupliment = barSupliment
        self.barAnounce = barAnounce
        self.cemail = cemail
        self.updated = updated
    }
    
    init?(dic:NSDictionary) {
        
        if let barBottle = (dic as AnyObject).value(forKey: BarKeys.barBottle.rawValue) as? NSArray{
            var drinks = [DrinkPricesModelW]()
            for data in barBottle{
                drinks.append(DrinkPricesModelW(dic: data as! NSDictionary)!)
            }
            self.barBottle = drinks
        }
        if let barWeekDay = (dic as AnyObject).value(forKey: BarKeys.barWeekDay.rawValue) as? NSArray{
            var days = [WeekDayModelW]()
            for data in barWeekDay{
                days.append(WeekDayModelW(dic: data as! NSDictionary)!)
            }
            self.barWeekDay = days
        }
        if let barHas = (dic as AnyObject).value(forKey: BarKeys.barHas.rawValue) as? NSArray{
            var has = [OnlyShowModelW]()
            for data in barHas{
                has.append(OnlyShowModelW(dic: data as! NSDictionary)!)
            }
            self.barHas = has
        }
        if let barAnounce = (dic as AnyObject).value(forKey: BarKeys.barAnounce.rawValue) as? [String:Any]{
            self.barAnounce = AnnounceModelW(dic: barAnounce as NSDictionary)
        }
        if let freeTable = (dic as AnyObject).value(forKey: BarKeys.freeTable.rawValue) as? [String:Any]{
            self.freeTable = FreeTableModelW(dic: freeTable as NSDictionary)
        }
        if let barSupliment = (dic as AnyObject).value(forKey: BarKeys.barSupliment.rawValue) as? [String:Any]{
            self.barSupliment = SuplimentModelW(dic: barSupliment as NSDictionary)
        }
        
    }
}

