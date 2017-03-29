//
//  IncomingChatTableViewCell.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class IncomingChatTableViewCell: UITableViewCell {

    //outlet for object
    @IBOutlet var viewIncoming: UIView!
    
    @IBOutlet var lblIncomingText: UILabel!
    @IBOutlet var lblIncomingTime: UILabel!
    
    var message : Message? {
        didSet{
            self.lblIncomingText?.text = message?.message
            self.lblIncomingTime?.text = CurrentTime.shared.currentTime()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewIncoming.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //autolayout function
//    override func draw(_ rect: CGRect) {
//        //function call for rounding corners
//        viewIncoming.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 20)
//    }
    
    override func layoutSubviews() {
    }
    
    
    
}
