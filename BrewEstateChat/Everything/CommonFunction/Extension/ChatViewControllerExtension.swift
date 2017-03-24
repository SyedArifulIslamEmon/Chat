//
//  ChatViewController.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 23/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import UIKit
import ISMessages

extension ChatViewController{
    
    //MARK:- LIFE CYCLE- ViewDidLoadOperation
    func chatViewControllerViewDidLoadOperation(){
        
        //function call to scroll table view to bottom
        tableViewScrollToBottom(animated: false)
        
        //dynamic height of table view cell
        tableViewChat.estimatedRowHeight = 30.0
        tableViewChat.rowHeight = UITableViewAutomaticDimension
        
        txtViewChat.sizeToFit()
        txtViewChat.layoutIfNeeded()
        let height = txtViewChat.sizeThatFits(CGSize(width: txtViewChat.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        txtViewChat.contentSize.height = height
        txtViewChat.layer.cornerRadius = 20
        txtViewChat.layer.masksToBounds=true
        txtViewChat.layer.borderColor=UIColor.white.cgColor
        txtViewChat.layer.borderWidth=2
        UITextView.setAnimationsEnabled(false)
        txtViewChat.contentInset = UIEdgeInsetsMake(2, 16, 2, -24);
        UITextView.setAnimationsEnabled(true)
        
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.height/2
        imgProfilePicture.layer.masksToBounds=true
        
        viewOption.layer.cornerRadius = 15
        viewOption.layer.masksToBounds=true
        viewOption.layer.borderColor=UIColor.init(red: 237/255, green: 239/255, blue: 240/255, alpha: 1).cgColor
        viewOption.layer.borderWidth=2
        
        btnSend.layer.cornerRadius = btnSend.frame.height/2
        btnSend.layer.masksToBounds=true
        btnSend.layer.borderColor=UIColor.white.cgColor
        
        tableViewChat.register(UINib(nibName: "IncomingChatTableViewCell", bundle: nil), forCellReuseIdentifier: "incomingChatTableViewCell")
        
        tableViewChat.register(UINib(nibName: "OutgoingChatTableViewCell", bundle: nil), forCellReuseIdentifier: "outgoingChatTableViewCell")
        
        //sendMessageAPI()
        pollingAPI()
        
    }
    
    func btnSendOperation() {
        
        tableViewScrollToBottom(animated: false)
        
        sentMessage.append(/txtViewChat.text)
        
        sentTime.append(/CurrentTime.shared.currentTime())
        
        sendMessageAPI()
        
        tableViewChat.reloadData()
        txtViewChat.text = ""
        //idArray?.removeAll()
    }
    
    func sendMessageAPI(){
        ISMessages.hideAlert(animated: true)
        
        APIManager.shared.request(with: EndPoint.sendMessage(api_token: "43", timezone: /CurrentTime.shared.currentTime(), other_id: "45", chat_type: "1", message: /txtViewChat.text), completion: {[weak self] (response) in
            self?.handleResponseSendMessageAPI(response: response)
        })
    }
    
    func handleResponseSendMessageAPI(response : Response) {
        switch response{
            
        case .success(let responseValue):
            
            guard let message = responseValue as? [Message] else {return}
            Alerts.shared.show(alert: .success, message: "success", type: .success)
            self.message = message
            
            //guard  let itemCount = sendMessage.dataSendMessage else {fatalError()}
            
            dataSource =  TableViewDataSource(items: message, height: UITableViewAutomaticDimension, tableView: tableViewChat, cellIdentifier: "outgoingChatTableViewCell", configureCellBlock: { (cell, item, indexPath) in
                    //Cell for row at indexpath
                
                (cell as? OutgoingChatTableViewCell)?.message = message[indexPath.row]
                
                    }, aRowSelectedListener: { (indexPath) in
                        //DidSelectRow at index path
        
                    }, DidScrollListener: nil)
            tableViewChat.delegate = dataSource
            tableViewChat.dataSource = dataSource
            tableViewChat.reloadData()
            
            
        case .failure(let str):
            Alerts.shared.show(alert: .oops, message: /str.rawValue, type: .error)
        }
    }
    
    func pollingAPI(){
        ISMessages.hideAlert(animated: true)
        
        APIManager.shared.request(with: EndPoint.polling(api_token: "45", other_id: "43", timezone: Keys.timezone.rV, id: "700"), completion: {[weak self] (response) in
            self?.handleResponsePollingAPI(response: response)
        })
    }
    
    func handleResponsePollingAPI(response : Response) {
        switch response{
            
        case .success(let responseValue):
            
            guard let polling = responseValue as? [Message] else {return}
            Alerts.shared.show(alert: .success, message: "success", type: .success)
            
            dataSource =  TableViewDataSource(items: polling, height: UITableViewAutomaticDimension, tableView: tableViewChat, cellIdentifier: "incomingChatTableViewCell", configureCellBlock: { (cell, item, indexPath) in
                //Cell for row at indexpath
                
                (cell as? IncomingChatTableViewCell)?.lblIncomingText.text = self.sentMessage[indexPath.row].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                (cell as? IncomingChatTableViewCell)?.lblIncomingTime.text = self.sentTime[indexPath.row]
                
            }, aRowSelectedListener: { (indexPath) in
                //DidSelectRow at index path
                
                
            }, DidScrollListener: nil)
            tableViewChat.delegate = dataSource
            tableViewChat.dataSource = dataSource
            tableViewChat.reloadData()
            
            
        case .failure(let str):
            Alerts.shared.show(alert: .oops, message: /str.rawValue, type: .error)
        }
    }

 
    
    //MARK:- VIEW DELEGATE- textViewDidBeginEditing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        viewOption.isHidden = true
    }

    //MARK:- FUNCTION- btnSendImageOperation
    func btnSendImageOperation(){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){}
    }
    
    //MARK:- FUNCTION- imagePickerControllerDidCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- FUNCTION- imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgProfilePicture?.image = image
            sendImage?.append(sendImageTemp!)
        }
        else{}
        self.dismiss(animated: true, completion: nil)
    }

    //MARK:- FUNCTION- tableViewScrollToBottom
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
            let numberOfSections = self.tableViewChat.numberOfSections,
            numberOfRows = self.tableViewChat.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.tableViewChat.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    //MARK:- FUNCTION- tapButton
    func tapButton(_ tap: Bool){
        if (doubleTap) {
            viewOption.isHidden = true
            doubleTap = false
        }
        else {
            viewOption.isHidden = false
            doubleTap = true
        }
    }

    class func instantiate(fromStoryboard name: String, id: String) -> Self? {
        return instantiateHelper(fromStoryboard: name, id: id)
    }
    
    private class func instantiateHelper<T>(fromStoryboard name: String, id: String) -> T? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id) as? T
        return controller
    }
}
