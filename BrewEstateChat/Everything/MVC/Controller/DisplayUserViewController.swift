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
    
    var dataSource = TableViewDataSource()
    
    var chats : [Chat]?{
        didSet{
            tableViewDisplayUser.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        DisplayUserViewControllerViewDidLoadOperation()
    }
}
