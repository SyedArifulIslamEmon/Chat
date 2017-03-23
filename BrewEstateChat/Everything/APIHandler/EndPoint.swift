//
//  Login.swift
//  APISampleClass
//
//  Created by cbl20 on 2/23/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import Alamofire

enum EndPoint {
    
    case messages(api_token : String? , timezone : String?)
    case sendMessage(api_token: String?, timezone: String?, other_id: String?, chat_type: String?, message: String?)
    case polling(api_token: String?, other_id: String?, timezone: String?, id: String?)
}


extension EndPoint : Router{
    
    var route : String  {
        
        switch self {
        
            case .messages(_): return APIConstants.messages
            case .sendMessage(_): return APIConstants.sendMessage
            case .polling(_): return APIConstants.polling
        }
    }
    
    var parameters: OptionalDictionary{
        return format()
    }
    
    
    func format() -> OptionalDictionary {
        
        switch self {
            
        case .messages(let api_token , let timezone):
            return Parameters.messages.map(values: [api_token,timezone])
            
        case .sendMessage(let api_token, let timezone, let other_id, let chat_type, let message):
            return Parameters.sendMessage.map(values: [api_token, timezone, other_id, chat_type, message])
            
        case .polling(let api_token, let other_id, let timezone, let id):
            return Parameters.polling.map(values: [api_token, other_id, timezone, id])
        }
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var baseURL: String{
        return APIConstants.basePath
    }
    
}
