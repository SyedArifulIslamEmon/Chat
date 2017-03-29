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
