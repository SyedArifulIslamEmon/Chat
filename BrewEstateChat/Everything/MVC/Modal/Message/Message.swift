//
//  Message.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 24/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//module imported
import Foundation
import SwiftyJSON

//model class defined for dataSendMessage
class Message: NSObject{
    
    var chat_type: String?,
    image: String?,
    video: String?,
    other_id: String?,
    timezone: String?,
    message: String?,
    id: String?,
    video_thumbnail: String?
    
    init(attributes: OptionalJSON) {
        super.init()
        
        chat_type = .chat_type => attributes
        image = .image => attributes
        video = .video => attributes
        other_id = .other_id => attributes
        timezone = .timezone => attributes
        message = .message => attributes
        id = .id => attributes
        video_thumbnail = .video_thumbnail => attributes
    }
    
    init(lastMessage : Message?,text: String?) {
        chat_type = "1"
        other_id = "43"
        message = text
        id = Int(lastMessage?.id ?? "")?.advanced(by: 1).description
    }
}
