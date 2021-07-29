//
//  OnlyShow.swift
//  Bebelo
//
//  Created by Buzzware Tech on 28/07/2021.
//

import Foundation
struct OnlyShowStruct {
    var title: String!
    var isSelected:Bool
    init(title:String,isSelected:Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
enum OnlyShowKeys:String,Codable {
    case title = "title"
    case isSelected = "isSelected"
}

class OnlyShowModelW:Codable {

    var titleKey: String!
    var title: String!
    var isSelectedKey: String!
    var isSelected:Bool!
    
    
    init(titleKey: String = OnlyShowKeys.title.rawValue,title:String? = nil,isSelectedKey: String = OnlyShowKeys.isSelected.rawValue,isSelected: Bool = false) {
        
        self.title = title
        self.isSelected = isSelected
        
    }
    
    init?(dic:NSDictionary) {
        self.titleKey = OnlyShowKeys.title.rawValue
        self.isSelectedKey = OnlyShowKeys.isSelected.rawValue
        let title = (dic as AnyObject).value(forKey: self.titleKey) as? String
        let isSelected = (dic as AnyObject).value(forKey: self.isSelectedKey) as? Bool
        
        self.title = title
        self.isSelected = isSelected
        
        
    }
}
class OnlyShowModel1:GenericDictionary,Codable {

    var title:String!
    {
        get{ return stringForKey(key: OnlyShowKeys.title.rawValue)}
        set{setValue(newValue, forKey: OnlyShowKeys.title.rawValue)}
    }
    var isSelected:Bool!
    {
        get{ return boolForKey(key: OnlyShowKeys.isSelected.rawValue,defaultValue: false)}
        set{setValue(newValue, forKey: OnlyShowKeys.isSelected.rawValue)}
    }
}
struct OnlyShowModel:Hashable,Codable {

    var title:String?
    var isSelected:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case isSelected = "isSelected"
    }
}
