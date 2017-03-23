//
//  DataPolling.swift
//  chat
//
//  Created by Sierra 4 on 16/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//


import Foundation
import SwiftyJSON

class DataPolling: NSObject{
    var chat_type: String?
    var created_at: String?
    var id: String?
    var is_read: String?
    var video: String?
    var message: String?
    var image: String?
    var video_thumbnail: String?
    
    required init(attributes: OptionalJSON) throws{
        super.init()
        
        chat_type = .chat_type => attributes
        created_at = .created_at => attributes
        id = .id => attributes
        is_read = .is_read => attributes
        video = .video => attributes
        message = .message => attributes
        image = .image => attributes
        video_thumbnail = .video_thumbnail => attributes
    }
}
