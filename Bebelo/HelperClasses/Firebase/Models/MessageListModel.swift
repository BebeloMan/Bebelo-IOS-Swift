//
//  MessageListModel.swift
//  MyReferral
//
//  Created by vision on 10/06/20.
//  Copyright © 2020 vision. All rights reserved.
//

import UIKit

struct MessageListModel {
    var receiverUser:UserModel
    var messagesList:[ChatModel]
    var conversationId:String
    var branchName:String?
}
