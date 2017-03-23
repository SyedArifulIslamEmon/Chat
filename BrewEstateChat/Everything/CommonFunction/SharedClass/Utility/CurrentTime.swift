//
//  CurrentTime.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 23/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation

class CurrentTime{

    static let shared = CurrentTime()
    
    //fetching date from device
    func currentTime() -> String{
    
        var time: String?
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        time = formatter.string(from: Date())
        return /time
    }
}
