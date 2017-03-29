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
    
    var message : Message? {
        didSet{
            self.lblOutgoingText?.text = message?.message
            self.lblOutgoingTime?.text = CurrentTime.shared.currentTime()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewOutgoing.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
