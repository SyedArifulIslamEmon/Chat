//
//  OutgoingChatTableViewCell.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class OutgoingChatTableViewCell: UITableViewCell {

    //outlet for object
    @IBOutlet var viewOutgoing: UIView!
    
    @IBOutlet var lblOutgoingText: UILabel!
    @IBOutlet var lblOutgoingTime: UILabel!
    
    @IBOutlet var imgDelivery: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //autolayout function
    override func draw(_ rect: CGRect) {
        //function call for rounding corners
        viewOutgoing.roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 20)
    }
    
}
