//
//  DisplayUserTableViewCell.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import Kingfisher

class DisplayUserTableViewCell: UITableViewCell {
    
    @IBOutlet var imgUserProfilePicture: UIImageView!
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblLastMessage: UILabel!
    @IBOutlet var lblLastMessageTime: UILabel!

    var chat : Chat? {
        didSet{
            self.lblUserName?.text = chat?.name
            self.lblLastMessage?.text = chat?.last_message
            self.lblLastMessageTime?.text = ""
            let url = URL(string: APIConstants.basePathimages + /chat?.profile_pic)
            self.imgUserProfilePicture?.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
