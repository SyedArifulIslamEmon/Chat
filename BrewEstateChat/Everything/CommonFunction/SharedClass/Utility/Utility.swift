//
//  Utility.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

//MARK:- MODULES
import Foundation
import UIKit
import NVActivityIndicatorView

//MARK:- CLASS- Utility
class Utility: UIViewController, NVActivityIndicatorViewable {
    
    //class object initialised
    static let functions = Utility()
    
    //function to show loader
    func startLoader()  {
        startAnimating(nil, message: nil, messageFont: nil, type: .lineSpinFadeLoader, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
    }
    
    //function to hide loader
    func removeLoader()  {
        stopAnimating()
    }
}
