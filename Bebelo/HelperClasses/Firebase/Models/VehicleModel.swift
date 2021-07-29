//
//  VehicleModel.swift
//  iRideDriver
//
//  Created by Buzzware Tech on 13/09/2021.
//

import UIKit


enum VehicleKeys:String {
    case userId = "userId"
    case make = "make"
    case model = "model"
    case year = "year"
    case color = "color"
    case tagNumber = "tagNumber"
    case noofDoors = "noofDoors"
    case noofSeatbelts = "noofSeatbelts"
    case insuranceUrl = "insuranceUrl"
    case registrationUrl = "registrationUrl"
    case licenseUrl = "licenseUrl"
    case frontCarUrl = "frontCarUrl"
    case leftCarUrl = "leftCarUrl"
    case rightCarUrl = "rightCarUrl"
    case rearCarUrl = "rearCarUrl"
    case frontInCarUrl = "frontInCarUrl"
    case backInCarUrl = "backInCarUrl"
    case carType = "carType"
    
}
class VehicleModel: GenericDictionary {

    
    var userId:String!
    {
        get{ return stringForKey(key: VehicleKeys.userId.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.userId.rawValue)}
    }
    var make:String!
    {
        get{ return stringForKey(key: VehicleKeys.make.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.make.rawValue)}
    }
    
    var model:String!
    {
        get{ return stringForKey(key: VehicleKeys.model.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.model.rawValue)}
    }
    
    var year:String!
    {
        get{ return stringForKey(key: VehicleKeys.year.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.year.rawValue)}
    }
    var color:String!
    {
        get{ return stringForKey(key: VehicleKeys.color.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.color.rawValue)}
    }
    var tagNumber:String!
    {
        get{ return stringForKey(key: VehicleKeys.tagNumber.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.tagNumber.rawValue)}
    }
    var noofDoors:String!
    {
        get{ return stringForKey(key: VehicleKeys.noofDoors.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.noofDoors.rawValue)}
    }
    var noofSetbealts:String!
    {
        get{ return stringForKey(key: VehicleKeys.noofSeatbelts.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.noofSeatbelts.rawValue)}
    }
    var insuranceUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.insuranceUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.insuranceUrl.rawValue)}
    }
    
    var registrationUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.registrationUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.registrationUrl.rawValue)}
        
    }
    var licenseUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.licenseUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.licenseUrl.rawValue)}
    }
    var frontCarUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.frontCarUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.frontCarUrl.rawValue)}
    }
    var leftCarUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.leftCarUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.leftCarUrl.rawValue)}
    }
    var rightCarUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.rightCarUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.rightCarUrl.rawValue)}
    }
    var rearCarUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.rearCarUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.rearCarUrl.rawValue)}
    }
    var frontInCarUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.frontInCarUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.frontInCarUrl.rawValue)}
    }
    var backInCarUrl:String!
    {
        get{ return stringForKey(key: VehicleKeys.backInCarUrl.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.backInCarUrl.rawValue)}
    }
    var carType:String!
    {
        get{ return stringForKey(key: VehicleKeys.carType.rawValue)}
        set{setValue(newValue, forKey: VehicleKeys.carType.rawValue)}
    }
    
}
class VehiclesModel{
    var name:String!
    var key: VehicleKeys!
    var value: String!
    var img: String!
    var loadImage:UIImage!
    var imgurl: String!
    var isUpload: Bool!
    var keyboardType:UIKeyboardType!
    var isSecure:Bool!
    var isTextField: Bool!
    init(name:String? = nil,key:VehicleKeys? = nil,value:String? = nil,img:String? = nil,loadImage:UIImage? = nil,imgurl:String? = nil,isUpload:Bool = false,keyboardType:UIKeyboardType = .default,isSecure:Bool = false,isTextField:Bool = true) {
        self.name = name
        self.key = key
        self.value = value
        self.img = img
        self.imgurl = imgurl
        self.isUpload = isUpload
        self.loadImage = loadImage
        self.keyboardType = keyboardType
        self.isSecure = isSecure
        self.isTextField = isTextField
    }
}
