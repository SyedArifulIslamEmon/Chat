//
//  DataSendMessage.swift
//  chat
//
//  Created by Sierra 4 on 01/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//module imported
import Foundation
import SwiftyJSON

//model class defined for dataSendMessage
class DataSendMessage: NSObject{
    
    var chat_type: String?,
    image: String?,
    video: String?,
    other_id: String?,
    timezone: String?,
    message: String?,
    id: String?,
    video_thumbnail: String?


    required init(attributes: OptionalJSON) throws{
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
}
