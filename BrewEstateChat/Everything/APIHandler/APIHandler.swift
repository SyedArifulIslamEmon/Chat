//
//  APIHandler.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import Foundation
import SwiftyJSON

extension EndPoint {
    
    func handle(parameters: JSON) -> Any? {
        switch self {
        case .polling(_):
            var messages : [Message] = []
            parameters["data"].arrayValue.forEach({ (element) in
                messages.append(Message(attributes: element.dictionaryValue))
            })
            return  messages
            
        case .messages(_):
            var messages : [Chat] = []
            parameters["data"].arrayValue.forEach({ (element) in
                messages.append(Chat(attributes: element.dictionaryValue))
            })
            return  messages
            
        case .sendMessage(_):
            
            return Message(attributes: parameters["data"].dictionaryValue )
        }
    }
}
