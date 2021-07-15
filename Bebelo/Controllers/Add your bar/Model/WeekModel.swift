//
//  WeekModel.swift
//  Bebelo
//
//  Created by Buzzware Tech on 15/07/2021.
//

import Foundation

struct WeekModel {
    let title:String!
    let isSelected:Bool!
    
    init(title:String,isSelected:Bool) {
        self.isSelected = isSelected
        self.title = title
    }
}
