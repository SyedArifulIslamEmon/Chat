//
//  Polling.swift
//  chat
//
//  Created by Sierra 4 on 06/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//module imported
import Foundation
import SwiftyJSON

//model class defined for polling api
class Polling: NSObject {
    var message: String?,
    success: String?,
    dataPolling: [DataPolling]?
    
    required init(attributes: OptionalJSON) throws{
        super.init()
        
        message = .message => attributes
        success = .success => attributes
        let dataPollingArray = Polling.parseArrayinToModal(withAttributes: .data =| attributes) as? [DataPolling]
        dataPolling = dataPollingArray
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
