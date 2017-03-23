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
    
    func handle(parameters : JSON) -> AnyObject? {
        switch self {
        case .messages(_):
            do {
                return try Messages(attributes: parameters.dictionaryValue )
            } catch _ { return nil }
            
        case .sendMessage(_):
            do {
                return try SendMessage(attributes: parameters.dictionaryValue )
            } catch _ { return nil }
            
        case .polling(_):
            do {
                return try Polling(attributes: parameters.dictionaryValue )
            } catch _ { return nil }
        }
    }
}
