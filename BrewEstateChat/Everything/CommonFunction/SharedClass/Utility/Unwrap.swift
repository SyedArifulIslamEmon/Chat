//
//  Unwrap.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 28/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULED
import Foundation

//MARK:- PROTOCOL- OptionalType
protocol OptionalType { init() }

//MARK:- EXTENSION
extension String: OptionalType {}
extension Int: OptionalType {}
extension Double: OptionalType {}
extension Bool: OptionalType {}
extension Int32: OptionalType {}

//prefix operator
prefix operator /

//prefix function
prefix func /<T: OptionalType>( lhs: T?) -> T {
    guard let validLhs = lhs else { return T() }
    return validLhs
}
