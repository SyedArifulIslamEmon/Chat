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

prefix operator /

//MARK:- FUNCTION-unwrappingString
prefix func /(value : String?) -> String {
    return value.unwrapString()
}

//MARK:- FUNCTION-unwrappingInt
prefix func /(value : Int?) -> Int {
    return value.unwrapInt()
}

//MARK:- FUNCTION-unwrappingInt32
prefix func /(value : Int32?) -> Int32 {
    return value.unwrapInt32()
}
