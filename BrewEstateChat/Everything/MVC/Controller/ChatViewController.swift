//
//  ChatViewController.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 22/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var lblUserName: UILabel!
    
    @IBOutlet var imgProfilePicture: UIImageView!
    
    @IBOutlet var viewOption: UIView!
    
    @IBOutlet var tableViewChat: UITableView!
    
    @IBOutlet var txtViewChat: UITextView!
    
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var btnSendImage: UIButton!
    
    var sendImage:[UIImage]?
    var sendImageTemp:UIImage?
    
    var sentTime:[String] = []
    var sentMessage:[String] = []
    
    var doubleTap:Bool = false
    
    var dataSource = TableViewDataSource()
    
    var message : [Message]?{
        didSet{
            tableViewChat.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatViewControllerViewDidLoadOperation()

//        dataSource 
    }
    
    @IBAction func btnSendOperation(_ sender: Any) {
        if(txtViewChat.text == "") {
            //if text view is empty, no action is performed
        }
        else {
            //function call for button send operation
            btnSendOperation()
        }
    }
    
    @IBAction func btnOptionOperation(_ sender: Any) {
        tapButton(doubleTap)
    }

    @IBAction func btnPop(_ sender: Any) {
        //poping the stack
        _ = self.navigationController?.popViewController(animated: true)
    }
}
