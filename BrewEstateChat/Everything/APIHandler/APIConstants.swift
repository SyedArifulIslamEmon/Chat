//
//  APIConstants.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//


import Foundation

internal struct APIConstants {
    static let basePath = "http://brewestateapp.code-brew.com/api/v1/"
    static let basePathimages = "https://s3.ap-south-1.amazonaws.com/brewestate/Uploads/"
    static let messages = "messages"
    static let sendMessage = "sendMessage"
    static let polling = "polling"
    static let status = "success"
    static let home = "home"
}

enum Keys : String{
    case id = "id"
    case api_token = "api_token"
    case timezone = "timezone"
    case other_id = "other_id"
    case chat_type = "chat_type"
    case message = "message"
    case timezoneValue = "Asia/Kolkata"
    
    var rV:String {
        return self.rawValue
    }
}

enum State : Int {
    case pending = 0
    case delivered = 1
    case success = 2
    
    var rV:Int {
        return self.rawValue
    }
}

enum StateResponse {
    case success(State)
    case delivered(State)
    case failure(State)
}

enum Validate : String {
    case none
    case success = "1"
    case failure = "0"
    case invalidAccessToken = "2"
    case fbLogin = "3"
    
    func map(response message : String?) -> String? {
        switch self {
        case .success:
            return message
        case .failure :
            return message
        case .invalidAccessToken :
            return message
        default:
            return nil
        }
    }
}

enum Response {
    case success(AnyObject?)
    case failure(Validate)
}

typealias OptionalDictionary = [String : String]?

struct Parameters {
    
    static let messages : [Keys] = [.api_token, .timezone]
    
    static let sendMessage : [Keys] = [.api_token, .timezone, .other_id, .chat_type, .message]
    
    static let polling : [Keys] = [.api_token, .other_id, .timezone, .id]
}
