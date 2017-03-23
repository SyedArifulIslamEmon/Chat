//
//  DisplayUserViewController.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import ISMessages
import Foundation

class DisplayUserViewController: UIViewController{

    @IBOutlet var tableViewDisplayUser: UITableView!
    
    var dataSourceTableViewDisplayUser = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewDisplayUser.register(UINib(nibName: "DisplayUserTableViewCell", bundle: nil), forCellReuseIdentifier: "displayUserTableViewCell")

        messagesAPI()
    }
}
