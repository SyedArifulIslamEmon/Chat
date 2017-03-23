//
//  Data.swift
//  chat
//
//  Created by Sierra 4 on 28/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//module imported
import Foundation
import UIKit
import SwiftyJSON

class DataMessage: NSObject {
    
    var profile_pic: String?
    var name: String?
    var last_message: String?
    var gender: String?
    var created_at: String?
    var chat_type: String?
    var chat_enabled: String?
    var is_blocked: String?
    var blocked_by_me: String?
    var id: String?
    
    required init(attributes: OptionalJSON) throws{
        super.init()
        
        profile_pic = .profile_pic => attributes
        name = .name => attributes
        last_message = .last_message => attributes
        gender = .gender => attributes
        created_at = .created_at => attributes
        chat_type = .chat_type => attributes
        chat_enabled = .chat_enabled => attributes
        is_blocked = .is_blocked => attributes
        blocked_by_me = .blocked_by_me => attributes
        id = .id => attributes
        
    }
}

