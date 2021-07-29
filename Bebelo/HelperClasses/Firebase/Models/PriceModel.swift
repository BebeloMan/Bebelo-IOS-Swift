//
//  PriceModel.swift
//  iRide
//
//  Created by Buzzware Tech on 14/12/2021.
//

import UIKit

enum PriceKeys:String {
    case bike = "bike"
    case rickshaw = "rickshaw"
    case go = "go"
    case goPlus = "goPlus"
    case business = "business"
    
}
class PriceModel: GenericDictionary {


    var bike:[String:Any]!
    {
        get{ return dictForKey(key: PriceKeys.bike.rawValue)}
        set{setValue(newValue, forKey: PriceKeys.bike.rawValue)}
    }
    var rickshaw:[String:Any]!
    {
        get{ return dictForKey(key: PriceKeys.rickshaw.rawValue)}
        set{setValue(newValue, forKey: PriceKeys.rickshaw.rawValue)}
    }
    var go:[String:Any]!
    {
        get{ return dictForKey(key: PriceKeys.go.rawValue)}
        set{setValue(newValue, forKey: PriceKeys.go.rawValue)}
    }
    var goPlus:[String:Any]!
    {
        get{ return dictForKey(key: PriceKeys.goPlus.rawValue)}
        set{setValue(newValue, forKey: PriceKeys.goPlus.rawValue)}
    }

    var business:[String:Any]!
    {
        get{ return dictForKey(key: PriceKeys.business.rawValue)}
        set{setValue(newValue, forKey: PriceKeys.business.rawValue)}
    }
}
enum PricesKeys:String {
    case costOfVehicle = "costOfVehicle"
    case initialFee = "initialFee"
    case name = "name"
    case pricePerKm = "pricePerKm"
    case pricePerMin = "pricePerMin"
    case carType = "carType"
    case amount = "amount"
    case time = "time"
    case image = "image"
    case date = "date"
    
}
class PricesModel: GenericDictionary {

    var costOfVehicle:String!
    {
        get{ return stringForKey(key: PricesKeys.costOfVehicle.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.costOfVehicle.rawValue)}
    }
    var initialFee:String!
    {
        get{ return stringForKey(key: PricesKeys.initialFee.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.initialFee.rawValue)}
    }
    
    var name:String!
    {
        get{ return stringForKey(key: PricesKeys.name.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.name.rawValue)}
    }
    var pricePerKm:String!
    {
        get{ return stringForKey(key: PricesKeys.pricePerKm.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.pricePerKm.rawValue)}
    }
    var pricePerMin:String!
    {
        get{ return stringForKey(key: PricesKeys.pricePerMin.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.pricePerMin.rawValue)}
    }
    var carType:String!
    {
        get{ return stringForKey(key: PricesKeys.carType.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.carType.rawValue)}
    }
    var amount:String!
    {
        get{ return stringForKey(key: PricesKeys.amount.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.amount.rawValue)}
    }
    var time:String!
    {
        get{ return stringForKey(key: PricesKeys.time.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.time.rawValue)}
    }
    var image:String!
    {
        get{ return stringForKey(key: PricesKeys.image.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.image.rawValue)}
    }
    var date:Int64!
    {
        get{ return int64ForKey(key: PricesKeys.date.rawValue)}
        set{setValue(newValue, forKey: PricesKeys.date.rawValue)}
    }
}
