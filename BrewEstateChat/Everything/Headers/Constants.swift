//
//  Constants.swift
//  HutchDecor
//
//  Created by Aseem 13 on 14/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Alert : String{
    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
}

infix operator =>
infix operator =|
infix operator =<

typealias OptionalJSON = [String : JSON]?

func =>(key : ParamKeys, json : OptionalJSON) -> String?{
    return json?[key.rawValue]?.stringValue
}

func =<(key : ParamKeys, json : OptionalJSON) -> [String : JSON]?{
    return json?[key.rawValue]?.dictionaryValue
}

func =|(key : ParamKeys, json : OptionalJSON) -> [JSON]?{
    return json?[key.rawValue]?.arrayValue
}
