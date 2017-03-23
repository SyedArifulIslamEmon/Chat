//
//  Extension.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import UIKit

//MARK:- FUNCTION-roundCorners
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)),
        mask = CAShapeLayer()
        
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds=true
    }
}

//MARK:- PROTOCOL-unwrappingString
protocol StringType { var get: String { get } }

extension String: StringType { var get: String { return self } }

extension Optional where Wrapped: StringType {
    func unwrapString() -> String {
        return self?.get ?? ""
    }
}

//MARK:- PROTOCOL-unwrappingInt
protocol IntType { var get: Int { get } }

extension Int: IntType { var get: Int { return self } }

extension Optional where Wrapped: IntType {
    func unwrapInt() -> Int {
        return self?.get ?? 0
    }
}

//MARK:- PROTOCOL-unwrappingInt32
protocol IntType32 { var get: Int32 { get } }

extension Int32: IntType32 { var get: Int32 { return self } }

extension Optional where Wrapped: IntType32 {
    func unwrapInt32() -> Int32 {
        return self?.get ?? 0
    }
}
