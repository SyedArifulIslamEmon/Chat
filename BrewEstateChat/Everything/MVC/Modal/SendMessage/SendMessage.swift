//
//  SendMessage.swift
//  chat
//
//  Created by Sierra 4 on 01/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//module imported
import Foundation
import SwiftyJSON

//model class defined for sendMessage api
class SendMessage: NSObject{
    var message: String?,
    dataSendMessage: DataSendMessage?,
    success: String?
    
    required init(attributes: OptionalJSON) throws{
        super.init()
        
        message = .message => attributes
        dataSendMessage = try DataSendMessage(attributes: .data =< attributes)
        success = .success => attributes
    }
}
