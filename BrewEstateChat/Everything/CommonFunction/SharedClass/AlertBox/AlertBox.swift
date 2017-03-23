//
//  AlertBox.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 23/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import UIKit
import ISMessages

typealias AlertBlock = (_ success: AlertTag) -> ()

enum AlertTag {
    case done
    case yes
    case no
}

class Alerts: NSObject {
    
    static let shared = Alerts()
    
    func show(alert title : Alert , message : String , type : ISAlertType){
        
        ISMessages.showCardAlert(withTitle: title.rawValue, message: message, duration: 2, hideOnSwipe: true, hideOnTap: true, alertType: type, alertPosition: .top, didHide: nil)
    }
}
