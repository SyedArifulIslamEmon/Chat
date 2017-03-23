//
//  Messages.swift
//  chat
//
//  Created by Sierra 4 on 28/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//module imported
import Foundation
import SwiftyJSON

//model class defined for messages api
class Messages: NSObject{
    
    var message: String?
    var success: String?
    var dataMessage: [DataMessage]?

    required init(attributes: OptionalJSON) throws{
        super.init()
        
        message = .message => attributes
        success = .success => attributes
        
        let dataMessageArray = Messages.parseArrayinToModal(withAttributes: .data =| attributes) as? [DataMessage]
        dataMessage = dataMessageArray
    }
    
    
    class func parseArrayinToModal(withAttributes attributes : [JSON]?) -> AnyObject? {
        
        var users : [DataMessage] = []
        guard let attri = attributes else { return nil }
        for dict in attri {
            do {
                let modal =  try DataMessage(attributes: dict.dictionaryValue)
                users.append(modal)
            } catch _ {
            }
        }
        return users as AnyObject?
    }
}
