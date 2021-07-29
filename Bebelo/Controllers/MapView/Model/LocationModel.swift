//
//  LocationModel.swift
//  DF1
//
//  Created by Buzzware Tech on 04/03/2021.
//

import UIKit
import CoreLocation

class LocationModel:Codable {

    var address_name:String!
    var address:String!
    var street_address_1:String!
    var street_address_2:String!
    var zipcode:String!
    var city:String!
    var state:String!
    var country:String!
    var address_lat:Double!
    var address_lng:Double!
    var throghfare:String!
    var subLocality:String!
    var zoom:CLLocationDistance!
    var pitch:CGFloat!
    var bearing:CLLocationDirection!
    init(address_name:String? = nil,address:String? = nil,street_address_1:String? = nil,street_address_2:String? = nil,zipcode:String? = nil,city:String? = nil,state:String? = nil,country:String? = nil,address_lat:Double? = nil,address_lng:Double? = nil,throghfare:String? = nil,subLocality:String? = nil,zoom:CLLocationDistance? = nil,pitch:CGFloat? = nil,bearing:CLLocationDirection? = nil) {
        self.address_name = address_name
        self.address = address
        self.street_address_1 = street_address_1
        self.street_address_2 = street_address_2
        self.zipcode = zipcode
        self.city = city
        self.state = state
        self.country = country
        self.address_lat = address_lat
        self.address_lng = address_lng
        self.throghfare = throghfare
        self.subLocality = subLocality
        self.zoom = zoom
        self.pitch = pitch
        self.bearing = bearing
    }
    init?(dic:NSDictionary) {
        
        
//        let address_name = (dic as AnyObject).value(forKey: Constant.address_name) as? String
//        let address = (dic as AnyObject).value(forKey: Constant.address) as? String
//        let address_lat = (dic as AnyObject).value(forKey: Constant.address_lat) as? Double
//        let address_lng = (dic as AnyObject).value(forKey: Constant.address_lng) as? Double
//        
//        
//        
//        self.address_name = address_name
//        self.address = address
//        self.address_lat = address_lat
//        self.address_lng = address_lng
        
    }
    
}
