//
//  WeekModel.swift
//  Bebelo
//
//  Created by Buzzware Tech on 15/07/2021.
//

import Foundation
import UIKit
struct WeekModel {
    let title:String!
    let isSelected:Bool!
    
    init(title:String,isSelected:Bool) {
        self.isSelected = isSelected
        self.title = title
    }
}
enum DrinkPriceKeys:String,Codable{
    case drinkName = "drinkName"
    case drinkImage = "drinkImage"
    case drinkPrice = "drinkPrice"
}
enum DrinkNameKeys:String,Codable,Equatable,CodingKey{
    case Caña = "Caña"
    case Doble = "Doble"
    case Tanqueray = "Tanqueray"
    case Beefeater = "Beefeater"
    case Brugal = "Brugal"
    case Seagram_s = "Seagram's"
    case Bombay_Sapphire = "Bombay Sapphire"
    case Barceló = "Barceló"
    case Santa_Teresa = "Santa Teresa"
    case Cacique = "Cacique"
    case Captain_Morgan = "Captain Morgan"
    case Johnnie_Walker_Red = "Johnnie Walker Red"
    case J_n_B = "J&B"
    case Absolut = "Absolut"
    case Nordés = "Nordés"
    case Bulldog = "Bulldog"
    case Hendrick_s = "Hendrick's"
    case Martin_Miller_s = "Martin Miller's"
    case Brockman_s = "Brockman's"
    case Havana_Club_7 = "Havana Club 7"
    case Johnnie_Walker_Black = "Johnnie Walker Black"
    case Jack_Daniel_s = "Jack Daniel's"
    case Grey_Goose = "Grey Goose"
    case Belvedere = "Belvedere"
    case Larios = "Larios"
    case Negrita = "Negrita"
    case Dyc = "Dyc"
    
}
class DrinkPricesModelW:Codable {
    
    var drinkNameKey: String!
    var drinkName: DrinkNameKeys!
    var drinkImage:String!
    var drinkPriceKey:String!
    var drinkPrice:String!
    
    init(drinkNameKey:String = DrinkPriceKeys.drinkName.rawValue,drinkName:DrinkNameKeys? = nil,drinkImage: String? = nil,drinkPriceKey: String = DrinkPriceKeys.drinkPrice.rawValue,drinkPrice: String? = nil) {
        
        self.drinkName = drinkName
        self.drinkImage = drinkImage
        self.drinkPrice = drinkPrice
    }
    
    init?(dic:NSDictionary) {
        self.drinkNameKey = DrinkPriceKeys.drinkName.rawValue
        self.drinkPriceKey = DrinkPriceKeys.drinkPrice.rawValue
        let drinkName = (dic as AnyObject).value(forKey: self.drinkNameKey) as? String
        let drinkImage = (dic as AnyObject).value(forKey: DrinkPriceKeys.drinkImage.rawValue) as? String
        if let drinkPrice = (dic as AnyObject).value(forKey: self.drinkPriceKey) as? String{
            self.drinkPrice = drinkPrice
        }
        else if let drinkPrice = (dic as AnyObject).value(forKey: self.drinkPriceKey) as? Double{
            self.drinkPrice = "\(drinkPrice)"
        }
        
        self.drinkName = DrinkNameKeys(rawValue:drinkName ?? "")
        self.drinkImage = drinkImage
        
        
    }
}
class DrinkPricesModel1:GenericDictionary,Codable {

    var drinkName:String!
    {
        get{ return stringForKey(key: DrinkPriceKeys.drinkName.rawValue)}
        set{setValue(newValue, forKey: DrinkPriceKeys.drinkName.rawValue)}
    }
    var drinkImage:String!
    {
        get{ return stringForKey(key: DrinkPriceKeys.drinkImage.rawValue)}
        set{setValue(newValue, forKey: DrinkPriceKeys.drinkImage.rawValue)}
    }

    var drinkPrice:String!
    {
        get{ return stringForKey(key: DrinkPriceKeys.drinkPrice.rawValue)}
        set{setValue(newValue, forKey: DrinkPriceKeys.drinkPrice.rawValue)}
    }

}
struct DrinkPricesModel:Hashable,Codable {
    
    var drinkName:DrinkNameKeys = .Doble
    var drinkImage:String?
    var drinkPrice:String?
    
    enum CodingKeys:String,CodingKey{
        case drinkName = "drinkName"
        case drinkImage = "drinkImage"
        case drinkPrice = "drinkPrice"
    }
    
}
enum DrinkPrice1Keys:String{
    case drinkCategory = "drinkCategory"
    case drinks = "drinks"
}

class DrinkPrices1ModelW:Codable {
    
    var drinkCategory: String!
    var drinks: [DrinkPricesModelW]!
    
    init(drinkCategory:String? = nil,drinks:[DrinkPricesModelW]? = nil) {
        
        self.drinkCategory = drinkCategory
        self.drinks = drinks
    }
    
    init?(dic:NSDictionary) {
        
        let drinkCategory = (dic as AnyObject).value(forKey: DrinkPrice1Keys.drinkCategory.rawValue) as? String
        let drinks = (dic as AnyObject).value(forKey: DrinkPrice1Keys.drinks.rawValue) as? [DrinkPricesModelW]
        
        self.drinkCategory = drinkCategory
        self.drinks = drinks
        
    }
}
class BarDetailModel:Codable {
    var value:String!
    var name:String!
    
    
    init(value:String? = nil,name:String) {
        self.value = value
        self.name = name
        
    }
}
class ContactInfoModel {
    var key:UserKeys!
    var value:String!
    var name:String!
    var keyBoardType:UIKeyboardType!
    var showText:Bool!
    
    init(key:UserKeys? = nil,value:String? = nil,name:String,keyBoardType:UIKeyboardType = .default,showText:Bool = false) {
        self.key = key
        self.value = value
        self.name = name
        self.keyBoardType = keyBoardType
        self.showText = showText
    }
}
//class WeekDayModel {
//    var svalue:String!
//    var evalue:String!
//    var name:String!
//
//
//    init(svalue:String? = nil,evalue:String? = nil,name:String) {
//        self.svalue = svalue
//        self.evalue = evalue
//        self.name = name
//
//    }
//}
enum WeekDayKeys:String,Codable {
    case svalue = "svalue"
    case evalue = "evalue"
    case name = "name"
    case weekDay = "weekDay"
}

class WeekDayModelW:Codable {
    
    var svalueKey:String!
    var svalue: Int64!
    var evalueKey:String!
    var evalue:Int64!
    var nameKey:String!
    var name:String!
    var weekDayKey:String!
    var weekDay:String!
    
    init(svalueKey:String = WeekDayKeys.svalue.rawValue,svalue:Int64? = nil,evalueKey:String =  WeekDayKeys.evalue.rawValue,evalue: Int64? = nil, nameKey:String = WeekDayKeys.name.rawValue,name: String? = nil,weekDayKey:String = WeekDayKeys.weekDay.rawValue,weekDay: String? = nil) {
        
        self.svalue = svalue
        self.evalue = evalue
        self.name = name
        self.weekDay = weekDay
    }
    
    init?(dic:NSDictionary) {
        self.svalueKey = WeekDayKeys.svalue.rawValue
        self.evalueKey = WeekDayKeys.evalue.rawValue
        self.nameKey = WeekDayKeys.name.rawValue
        self.weekDayKey = WeekDayKeys.weekDay.rawValue
        let svalue = (dic as AnyObject).value(forKey: self.svalueKey) as? Int64
        let evalue = (dic as AnyObject).value(forKey: self.evalueKey) as? Int64
        let name = (dic as AnyObject).value(forKey: self.nameKey) as? String
        let weekDay = (dic as AnyObject).value(forKey: self.weekDayKey) as? String
        
        self.svalue = svalue
        self.evalue = evalue
        self.name = name
        self.weekDay = weekDay
        
    }
}
class WeekDayModel1:GenericDictionary,Codable {

    var svalue:Int64!
    {
        get{ return int64ForKey(key: WeekDayKeys.svalue.rawValue)}
        set{setValue(newValue, forKey: WeekDayKeys.svalue.rawValue)}
    }
    var evalue:Int64!
    {
        get{ return int64ForKey(key: WeekDayKeys.evalue.rawValue)}
        set{setValue(newValue, forKey: WeekDayKeys.evalue.rawValue)}
    }
    var name:String!
    {
        get{ return stringForKey(key: WeekDayKeys.name.rawValue)}
        set{setValue(newValue, forKey: WeekDayKeys.name.rawValue)}
    }
    var weekDay:String!
    {
        get{ return stringForKey(key: WeekDayKeys.weekDay.rawValue)}
        set{setValue(newValue, forKey: WeekDayKeys.weekDay.rawValue)}
    }
}
enum WeekDay1Keys:String {
    case weekDay = "weekDay"
    case name = "name"
}
struct WeekDayModel:Hashable,Codable {
    
    var svalue:Int64?
    var evalue:Int64?
    var name:String?
    var weekDay:weekfullDay? = .none
    
    enum CodingKeys: String, CodingKey {
        case svalue = "svalue"
        case evalue = "evalue"
        case name = "name"
        case weekDay = "weekDay"
    }
}

