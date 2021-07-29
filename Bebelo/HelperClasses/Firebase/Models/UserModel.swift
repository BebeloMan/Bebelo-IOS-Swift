//
//  UserModel.swift
//  MyReferral
//
//  Created by vision on 15/05/20.
//  Copyright © 2020 vision. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import Foundation
enum UserKeyss:String {
    case uuid = "uuid"
    case baddress = "baddress"
    case barBottle = "barBottle"
    case barHas = "barHas"
    case barWeekDay = "barWeekDay"
    case blat = "blat"
    case blng = "blng"
    case image = "image"
    case pinimage = "pinimage"
    case bname = "bname"
    case cemail = "cemail"
    case cname = "cname"
    case cpassword = "cpassword"
    case cphone = "cphone"
    case deviceType = "deviceType"
    case isSupliment = "isSupliment"
    case token = "token"
    case userDate = "userDate"
    case isAnnounce = "isAnnounce"
    case announce = "announce"
    case announceDate = "announceDate"
    case isFreeTable = "isFreeTable"
    case freeTableDate = "freeTableDate"
    case isopend = "isopend"
    case displaytime = "displaytime"
    case displayPrice = "displayPrice"
    case status = "status"
    case isAdded = "isAdded"
    case closingtype = "closingtype"
    case rangeKm = "rangeKm"
    
}
struct UserModel: Identifiable,Codable {

    @DocumentID
    var id: String?
    var uuid:Int64 = 0
    var baddress:String? = ""
    var barBottle:[DrinkPricesModel]?
    var barHas:[OnlyShowModel]?
    var barWeekDay:[WeekDayModel]?
    var blat:Double! = 0
    var blng:Double! = 0
    var image:String? = ""
    var pinimage:String? = ""
    var bname:String! = ""
    var cemail:String? = ""
    var cname:String? = ""
    var cpassword:String? = ""
    var cphone:String? = ""
    var deviceType:String? = ""
    var isSupliment:Bool! = false
    var token:String? = ""
    var userDate:Int64? = 0
    var isAnnounce:Bool = false
    var announce:String? = ""
    var announceDate:Int64? = 0
    var isFreeTable:Bool = false
    var freeTableDate:Int64? = 0
    var isopend:Bool! = false
    var displaytime:String? = ""
    var displayPrice:String? = ""
    var status:String? = ""
    var isAdded:Bool? = false
    var closingtype:String? = ""
    var rangeKm:Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case uuid = "uuid"
        case baddress = "baddress"
        case barBottle = "barBottle"
        case barHas = "barHas"
        case barWeekDay = "barWeekDay"
        case blat = "blat"
        case blng = "blng"
        case image = "image"
        case pinimage = "pinimage"
        case bname = "bname"
        case cemail = "cemail"
        case cname = "cname"
        case cpassword = "cpassword"
        case cphone = "cphone"
        case deviceType = "deviceType"
        case isSupliment = "isSupliment"
        case token = "token"
        case userDate = "userDate"
        case isAnnounce = "isAnnounce"
        case announce = "announce"
        case announceDate = "announceDate"
        case isFreeTable = "isFreeTable"
        case freeTableDate = "freeTableDate"
        case isopend = "isopend"
        case displaytime = "displaytime"
        case displayPrice = "displayPrice"
        case status = "status"
        case isAdded = "isAdded"
        case closingtype = "closingtype"
        case rangeKm = "rangeKm"
    }
    
    
}
extension UserModel{
    static let empty = UserModel(id: "", uuid: 0, baddress: "", barBottle: [], barHas: [], barWeekDay: [], blat: 0, blng: 0, image: "", pinimage: "", bname: "", cemail: "", cname: "", cpassword: "", cphone: "", deviceType: "", isSupliment: false, token: "", userDate: 0, isAnnounce: false, announce: "", announceDate: 0, isFreeTable: false, freeTableDate: 0, isopend: false, displaytime: "", displayPrice: "", status: "", isAdded: false, closingtype: "",rangeKm: 0)
}
enum VisitorKeys:String {
    case date = "date"
    case gender = "gender"
    case dailyUse = "dailyUse"
    case flag = "flag"
    case updatedOn = "updatedOn"
    case timestamp = "timestamp"
    case user_id = "user_id"
    
    
}
class VisitorModel: GenericDictionary {

    
    var date:String!
    {
        get{ return stringForKey(key: VisitorKeys.date.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.date.rawValue)}
    }
    
    var gender:String!
    {
        get{ return stringForKey(key: VisitorKeys.gender.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.gender.rawValue)}
    }
    var timestamp:Int64!
    {
        get{ return int64ForKey(key: VisitorKeys.timestamp.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.timestamp.rawValue)}
    }
    var updatedOn:String!
    {
        get{ return stringForKey(key: VisitorKeys.updatedOn.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.updatedOn.rawValue)}
    }
    var dailyUse:Int64!
    {
        get{ return int64ForKey(key: VisitorKeys.dailyUse.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.dailyUse.rawValue)}
    }
    
    var flag:[String:Any]!
    {
        get{ return dictForKey(key: VisitorKeys.flag.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.flag.rawValue)}
    }
    var user_id:Int64!
    {
        get{ return int64ForKey(key: VisitorKeys.user_id.rawValue)}
        set{setValue(newValue, forKey: VisitorKeys.user_id.rawValue)}
    }
    
    
}
enum User2Keys:String {
    case dailyUse = "dailyUse"
    case flag = "flag"
    case timestamp = "timestamp"
    case updatedOn = "updatedOn"
    case user_id = "user_id"
}
class User2Model: GenericDictionary {

    
    var dailyUse:Int64!
    {
        get{ return int64ForKey(key: User2Keys.dailyUse.rawValue)}
        set{setValue(newValue, forKey: User2Keys.dailyUse.rawValue)}
    }
    var timestamp:Int64!
    {
        get{ return int64ForKey(key: User2Keys.timestamp.rawValue)}
        set{setValue(newValue, forKey: User2Keys.timestamp.rawValue)}
    }
    
    var updatedOn:String!
    {
        get{ return stringForKey(key: User2Keys.updatedOn.rawValue)}
        set{setValue(newValue, forKey: User2Keys.updatedOn.rawValue)}
    }
    var flag:[String:Any]!
    {
        get{ return dictForKey(key: User2Keys.flag.rawValue)}
        set{setValue(newValue, forKey: User2Keys.flag.rawValue)}
    }
    var user_id:Int64!
    {
        get{ return int64ForKey(key: User2Keys.user_id.rawValue)}
        set{setValue(newValue, forKey: User2Keys.user_id.rawValue)}
    }
    
}
enum UserKeys1:String {
    case uuid = "uuid"
    case baddress = "baddress"
    case barBottle = "barBottle"
    case barHas = "barHas"
    case barWeekDay = "barWeekDay"
    case blat = "blat"
    case blng = "blng"
    case image = "image"
    case pinimage = "pinimage"
    case bname = "bname"
    case cemail = "cemail"
    case cname = "cname"
    case cpassword = "cpassword"
    case cphone = "cphone"
    case deviceType = "deviceType"
    case isSupliment = "isSupliment"
    case token = "token"
    case userDate = "userDate"
    case isAnnounce = "isAnnounce"
    case announce = "announce"
    case announceDate = "announceDate"
    case isFreeTable = "isFreeTable"
    case freeTableDate = "freeTableDate"
    case isopend = "isopend"
    case displaytime = "displaytime"
    case displayPrice = "displayPrice"
    case status = "status"
    case isAdded = "isAdded"
    case closingtype = "closingtype"
    case rangeKm = "rangeKm"

}
class UserModel1: GenericDictionary {

    var uuid:Int64!
    {
        get{ return int64ForKey(key: UserKeys1.uuid.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.uuid.rawValue)}
    }
    var baddress:String!
    {
        get{ return stringForKey(key: UserKeys1.baddress.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.baddress.rawValue)}
    }
    var barBottle:[[String:Any]]!
    {
        get{ return dictArrayForKey(key: UserKeys1.barBottle.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.barBottle.rawValue)}
    }

    var barHas:[[String:Any]]!
    {
        get{ return dictArrayForKey(key: UserKeys1.barHas.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.barHas.rawValue)}
    }
    var barWeekDay:[[String:Any]]!
    {
        get{ return dictArrayForKey(key: UserKeys1.barWeekDay.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.barWeekDay.rawValue)}
    }
    var blat:Double!
    {
        get{ return doubleForKey(key: UserKeys1.blat.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.blat.rawValue)}
    }
    var blng:Double!
    {
        get{ return doubleForKey(key: UserKeys1.blng.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.blng.rawValue)}
    }
    var image:String!
    {
        get{ return stringForKey(key: UserKeys1.image.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.image.rawValue)}
    }
    var pinimage:String!
    {
        get{ return stringForKey(key: UserKeys1.pinimage.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.pinimage.rawValue)}
    }
    var bname:String!
    {
        get{ return stringForKey(key: UserKeys1.bname.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.bname.rawValue)}
    }
    var cemail:String!
    {
        get{ return stringForKey(key: UserKeys1.cemail.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.cemail.rawValue)}
    }
    var cname:String!
    {
        get{ return stringForKey(key: UserKeys1.cname.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.cname.rawValue)}
    }
    var cpassword:String!
    {
        get{ return stringForKey(key: UserKeys1.cpassword.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.cpassword.rawValue)}
    }
    var cphone:String!
    {
        get{ return stringForKey(key: UserKeys1.cphone.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.cphone.rawValue)}
    }
    var deviceType:String!
    {
        get{ return stringForKey(key: UserKeys1.deviceType.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.deviceType.rawValue)}
    }
    var isSupliment:Bool!
    {
        get{ return boolForKey(key: UserKeys1.isSupliment.rawValue, defaultValue: false)}
        set{setValue(newValue, forKey: UserKeys1.isSupliment.rawValue)}
    }
    var token:String!
    {
        get{ return stringForKey(key: UserKeys1.token.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.token.rawValue)}
    }
    var userDate:Int64!
    {
        get{ return int64ForKey(key: UserKeys1.userDate.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.userDate.rawValue)}
    }
    var isAnnounce:Bool!
    {
        get{ return boolForKey(key: UserKeys1.isAnnounce.rawValue, defaultValue: false)}
        set{setValue(newValue, forKey: UserKeys1.isAnnounce.rawValue)}
    }
    var announce:String!
    {
        get{ return stringForKey(key: UserKeys1.announce.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.announce.rawValue)}
    }

    var announceDate:Int64!
    {
        get{ return int64ForKey(key: UserKeys1.announceDate.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.announceDate.rawValue)}
    }
    var isFreeTable:Bool!
    {
        get{ return boolForKey(key: UserKeys1.isFreeTable.rawValue, defaultValue: false)}
        set{setValue(newValue, forKey: UserKeys1.isFreeTable.rawValue)}
    }
    var freeTableDate:Int64!
    {
        get{ return int64ForKey(key: UserKeys1.freeTableDate.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.freeTableDate.rawValue)}
    }
    var isopend:Bool!
    {
        get{ return boolForKey(key: UserKeys1.isopend.rawValue, defaultValue: false)}
        set{setValue(newValue, forKey: UserKeys1.isopend.rawValue)}
    }
    var displaytime:String!
    {
        get{ return stringForKey(key: UserKeys1.displaytime.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.displaytime.rawValue)}
    }
    var displayPrice:String!
    {
        get{ return stringForKey(key: UserKeys1.displayPrice.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.displayPrice.rawValue)}
    }
    var status:String!
    {
        get{ return stringForKey(key: UserKeys1.status.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.status.rawValue)}
    }
    var isAdded:Bool!
    {
        get{ return boolForKey(key: UserKeys1.isAdded.rawValue, defaultValue: false)}
        set{setValue(newValue, forKey: UserKeys1.isAdded.rawValue)}
    }
    var closingtype:String!
    {
        get{ return stringForKey(key: UserKeys1.closingtype.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.closingtype.rawValue)}
    }
    var rangeKm:Int!
    {
        get{ return intForKey(key: UserKeys1.rangeKm.rawValue)}
        set{setValue(newValue, forKey: UserKeys1.rangeKm.rawValue)}
    }

}
