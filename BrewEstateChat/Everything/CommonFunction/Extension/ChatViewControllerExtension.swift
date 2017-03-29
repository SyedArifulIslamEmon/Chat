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
import IQKeyboardManagerSwift

extension ChatViewController: UITextViewDelegate{
    
    //MARK:- LIFE CYCLE- ViewDidLoadOperation
    func chatViewControllerViewDidLoadOperation(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        //function call to scroll table view to bottom
        tableViewScrollToBottom(animated: false)
        
        //dynamic height of table view cell
        tableViewChat.estimatedRowHeight = 30.0
        tableViewChat.rowHeight = UITableViewAutomaticDimension
        
        txtViewChat.sizeToFit()
        txtViewChat.layoutIfNeeded()
        let height = txtViewChat.sizeThatFits(CGSize(width: txtViewChat.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        txtViewChat.contentSize.height = height
        txtViewChat.layer.cornerRadius = txtViewChat.frame.height/2
        txtViewChat.layer.masksToBounds=true
        txtViewChat.layer.borderColor=UIColor.white.cgColor
        txtViewChat.layer.borderWidth=2
        UITextView.setAnimationsEnabled(false)
        //txtViewChat.contentInset = UIEdgeInsetsMake(2, 16, 2, 20)
        txtViewChat.textContainerInset = UIEdgeInsets(top: 12, left: 20, bottom: 2, right: 20)
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
        
        
        tableViewChat.register(UINib(nibName: "IncomingChatTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "IncomingChatTableViewCell")
        tableViewChat.register(UINib(nibName: "OutgoingChatTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "OutgoingChatTableViewCell")
        
        dataSourceIncoming()
        //sendMessageAPI()
        startTimer()
        
       
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        IQKeyboardManager.sharedManager().enable = false
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//         IQKeyboardManager.sharedManager().enable = true
//    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            print(keyboardHeight ?? "keyboard height not found")
        }
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
       // bottomConstraintTextView.constant = keyboardHeight ?? 0
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        bottomConstraintTextView.constant = 20
//    }
    
    
    
    func dataSourceIncoming(){
        dataSource =  TableViewDataSource(items: messages, height: UITableViewAutomaticDimension, tableView: tableViewChat, cellIdentifier: nil, configureCellBlock: { (cell, item, indexPath) in
            //Cell for row at indexpath
            
            (cell as? IncomingChatTableViewCell)?.message = self.messages?[indexPath.row]
            (cell as? OutgoingChatTableViewCell)?.message = self.messages?[indexPath.row]
            
        }, aRowSelectedListener: { (indexPath) in
            //DidSelectRow at index path
            
        }, DidScrollListener: nil)
        dataSource.isChat = true
        tableViewChat.delegate = dataSource
        tableViewChat.dataSource = dataSource
        tableViewChat.reloadData()
    }
    
    func btnSendOperation() {
    
        //messages.append(/txtViewChat.text)
        
        let message = Message(lastMessage: self.messages?.last, text: txtViewChat?.text)

        self.messages?.append(message)
        self.dataSource.items = self.messages
        tableViewChat.beginUpdates()
        tableViewChat.insertRows(at: [IndexPath(row: /messages?.count - 1, section: 0)], with: .right)
        tableViewChat.endUpdates()
        tableViewScrollToBottom(animated: false)
        sendMessageAPI()
        txtViewChat.text = ""
        //idArray?.removeAll()
    }
    
    func sendMessageAPI(){
        ISMessages.hideAlert(animated: true)
//        let message = Message(lastMessage: self.messages?.last, text: /txtViewChat.text)
//        self.messages?.append(message)
//        self.tableViewChat.reloadData()
        APIManager.shared.request(with: EndPoint.sendMessage(api_token: "43", timezone: /CurrentTime.shared.currentTime(), other_id: "45", chat_type: "1", message: /txtViewChat.text), completion: { (response) in
        })
    }
    
    
    //MARK:- TIMER- pollingMethod
    func startTimer(){
        if check == false{
            Utility.functions.startLoader()
        }
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(callPollingMethod), userInfo: nil, repeats: true)
    }
    
    func callPollingMethod(){
        pollingAPI()
    }
    
    func pollingAPI(){
        //self.messages?.removeAll()
        
        ISMessages.hideAlert(animated: true)
        
        APIManager.shared.request(with: EndPoint.polling(api_token: "43", other_id: "45", timezone: Keys.timezone.rV, id: String(lastId)), completion: {[weak self] (response) in
            self?.handleResponsePollingAPI(response: response)
        })
    }
    
    func handleResponsePollingAPI(response : Response) {
        switch response{
            
        case .success(let responseValue):
            
            guard var polling = responseValue as? [Message],polling.count > 0 else { return }
            if self.messages == nil {
                self.messages = []
            }
            polling = polling.map({ msg in
                let message = msg
                message.other_id = "45"
                return message
            })
            self.messages?.append(contentsOf: polling)
            
            lastId = /Int(/messages?[/messages?.count - 1].id)
            
            dataSourceIncoming()
            dataSource.items = self.messages
            tableViewChat.deleteRows(at: [IndexPath(row: /messages?.count - 1, section: 0)], with: .fade)
            tableViewChat.beginUpdates()
            tableViewChat.insertRows(at: [IndexPath(row: /self.messages?.count - 1, section: 0)], with: .left)
            tableViewChat.endUpdates()
            tableViewScrollToBottom(animated: false)
            //tableViewChat.reloadData()
            
            Utility.functions.removeLoader()
            check = true
           
            //self.messages?.append(contentsOf: polling)
            
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
