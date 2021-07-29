//
//  PolylineModel.swift
//  iRideDriver
//
//  Created by Buzzware Tech on 10/12/2021.
//

import UIKit

class PolylineModel {

    var polyline:String!
    var distance: Int64!
    var time: Int64!
    
    init(polyline:String? = nil,distance:Int64? = nil,time:Int64? = nil) {
        self.polyline = polyline
        self.distance = distance
        self.time = time
        
    }
}
