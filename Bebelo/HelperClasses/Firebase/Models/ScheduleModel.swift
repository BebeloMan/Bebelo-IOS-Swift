//
//  ScheduleModel.swift
//  iRide
//
//  Created by Buzzware Tech on 13/12/2021.
//

import UIKit

enum ScheduleKeys:String {
    case id = "id"
    case bookingDate = "bookingDate"
    case price = "price"
    case pm_id = "pm_id"
    case status = "status"
    case tripDetail = "tripDetail"
    case userId = "userId"
    case scheduleTimeStamp = "scheduleTimeStamp"
    case carType = "carType"
    
}
class ScheduleModel:GenericDictionary {

    var id:String!
    {
        get{ return stringForKey(key: ScheduleKeys.id.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.id.rawValue)}
    }
    var bookingDate:Int64!
    {
        get{ return int64ForKey(key: ScheduleKeys.bookingDate.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.bookingDate.rawValue)}
    }
    var price:String!
    {
        get{ return stringForKey(key: ScheduleKeys.price.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.price.rawValue)}
    }
    var pm_id:String!
    {
        get{ return stringForKey(key: ScheduleKeys.pm_id.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.pm_id.rawValue)}
    }
    var status:String!
    {
        get{ return stringForKey(key: ScheduleKeys.status.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.status.rawValue)}
    }
    var tripDetail:[String:Any]!
    {
        get{ return dictForKey(key: ScheduleKeys.tripDetail.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.tripDetail.rawValue)}
    }
    var userId:String!
    {
        get{ return stringForKey(key: ScheduleKeys.userId.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.userId.rawValue)}
    }
    var scheduleTimeStamp:Int64!
    {
        get{ return int64ForKey(key: ScheduleKeys.scheduleTimeStamp.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.scheduleTimeStamp.rawValue)}
    }
    var carType:String!
    {
        get{ return stringForKey(key: ScheduleKeys.carType.rawValue)}
        set{setValue(newValue, forKey: ScheduleKeys.carType.rawValue)}
    }
    
}

