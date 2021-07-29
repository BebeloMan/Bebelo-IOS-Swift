//
//  ChatModel.swift
//  MyReferral
//
//  Created by vision on 09/06/20.
//  Copyright © 2020 vision. All rights reserved.
//

import UIKit

class ChatModel: GenericDictionary {
    var content:String
    {
        get{ return stringForKey(key: "content")}
        set{setValue(newValue, forKey: "content")}
    }
    
    var fromID:String
    {
        get{ return stringForKey(key: "fromID")}
        set{setValue(newValue, forKey: "fromID")}
    }
    
    var toID:String
    {
        get{ return stringForKey(key: "toID")}
        set{setValue(newValue, forKey: "toID")}
    }
    
    var timestamp:Int64
    {
        get{ return int64ForKey(key: "timestamp")}
        set{setValue(newValue, forKey: "timestamp")}
    }
    
    var type:String
    {
        get{ return stringForKey(key: "type")}
        set{setValue(newValue, forKey: "type")}
    }
    
    var isRead:Bool?
    {
        get{ return boolForKey(key: "isRead", defaultValue: false)}
        set{setValue(newValue, forKey: "isRead")}
    }
    
    var messageId:String
    {
        get{ return stringForKey(key: "messageId")}
        set{setValue(newValue, forKey: "messageId")}
    }
}
