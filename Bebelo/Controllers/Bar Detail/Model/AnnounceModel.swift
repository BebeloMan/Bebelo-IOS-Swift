//
//  AnnounceModel.swift
//  Bebelo
//
//  Created by Buzzware Tech on 15/09/2021.
//

import UIKit

enum AnnounceKeys:String {
    case name = "name"
    case date = "date"
    case data = "data"
}


class AnnounceModelW:Codable {
    
    //var name: String!
    var date:Int64!
    var data:String!
    
    init(/*name:String? = nil,*/date: Int64? = nil,data: String? = nil) {
        //self.name = name
        self.date = date
        self.data = data
    }
    
    init?(dic:NSDictionary) {
        
        //let name = (dic as AnyObject).value(forKey: AnnounceKeys.name.rawValue) as? String
        let date = (dic as AnyObject).value(forKey: AnnounceKeys.date.rawValue) as? Int64
        let data = (dic as AnyObject).value(forKey: AnnounceKeys.data.rawValue) as? String
        
        //self.name = name
        self.date = date
        self.data = data
        
    }
}
enum FreeTableKeys:String {
    case freeTable = "freeTable"
    case date = "date"
}
class FreeTableModelW:Codable {
    
    var freeTable: Bool!
    var date:Int64!
    
    init(name:
         Bool? = nil,date: Int64? = nil) {
        self.freeTable = name
        self.date = date
    }
    
    init?(dic:NSDictionary) {
        
        let freeTable = (dic as AnyObject).value(forKey: FreeTableKeys.freeTable.rawValue) as? Bool
        let date = (dic as AnyObject).value(forKey: FreeTableKeys.date.rawValue) as? Int64
        
        self.freeTable = freeTable
        self.date = date
        
    }
}
enum SuplimentKeys:String {
    case isSupliment = "isSupliment"
    case rate = "rate"
    case type = "type"
}
class SuplimentModelW:Codable {
    
    var isSupliment: Bool!
    var rate:String!
    var type:String!
    
    init(isSupliment:
         Bool? = nil,rate: String? = nil,type: String? = nil) {
        self.isSupliment = isSupliment
        self.rate = rate
        self.type = type
    }
    
    init?(dic:NSDictionary) {
        
        let isSupliment = (dic as AnyObject).value(forKey: SuplimentKeys.isSupliment.rawValue) as? Bool
        let rate = (dic as AnyObject).value(forKey: SuplimentKeys.rate.rawValue) as? String
        let type = (dic as AnyObject).value(forKey: SuplimentKeys.type.rawValue) as? String
        
        self.isSupliment = isSupliment
        self.rate = rate
        self.type = type
        
    }
}
