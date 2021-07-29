//
//  AnnotationModel.swift
//  Bebelo
//
//  Created by Buzzware Tech on 05/08/2021.
//

import UIKit
import CoreLocation
enum Annoucement:String,Codable {
    case Announcement = "Announcement"
    case Free_table_on_the_terrace = "Free table on the terrace"
    case Both_announcement_and_free_table = "Both announcement and free table"
    case None = "None"
}
class AnnotationModel:Hashable {
    
    static func == (lhs: AnnotationModel, rhs: AnnotationModel) -> Bool {
        return lhs.uuid == rhs.uuid && rhs.uuid == lhs.uuid
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
            hasher.combine(uuid)
        }

    var title:String!
    var pinImage:String!
    var barImage:String!
    var location:CLLocationCoordinate2D!
    var announce:Annoucement!
    var annouceName:String!
    var barHas:[OnlyShowModel]!
    var weekDay:[WeekDayModel]!
    var barId:String!
    var barData:UserModel!
    var rooftop:OnlyShowModel!
    var terrace:OnlyShowModel!
    var isAdded:Bool!
    var uuid:Int64
    init(title:String? = nil,pinImage:String? = nil,barImage:String? = nil,location:CLLocationCoordinate2D? = nil,announce:Annoucement = .None,annouceName:String? = nil,barHas:[OnlyShowModel]? = nil,weekDay:[WeekDayModel]? = nil,barId:String? = nil,barData:UserModel? = nil,rooftop:OnlyShowModel? = nil,terrace:OnlyShowModel? = nil,isAdded:Bool = false,uuid:Int64 = 0) {
        self.title = title
        self.pinImage = pinImage
        self.barImage = barImage
        self.location = location
        self.announce = announce
        self.annouceName = annouceName
        self.barHas = barHas
        self.weekDay = weekDay
        self.barId = barId
        self.barData = barData
        self.rooftop = rooftop
        self.terrace = terrace
        self.isAdded = isAdded
        self.uuid = uuid
    }
}
