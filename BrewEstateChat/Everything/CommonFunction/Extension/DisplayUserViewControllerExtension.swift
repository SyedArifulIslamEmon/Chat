//
//  DisplayUserViewControllerExtension.swift
//  BrewEstateChat
//
//  Created by Sierra 4 on 23/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import Foundation
import ISMessages

extension DisplayUserViewController{
    
    func DisplayUserViewControllerViewDidLoadOperation(){
        
        tableViewDisplayUser.register(UINib(nibName: "DisplayUserTableViewCell", bundle: nil), forCellReuseIdentifier: "displayUserTableViewCell")
        
        messagesAPI()
    }

    func messagesAPI(){
        ISMessages.hideAlert(animated: true)
        
        APIManager.shared.request(with: EndPoint.messages(api_token : "43" , timezone : "Asia/Kolkata"), completion: {[weak self] (response) in
            
            self?.handleResponse(response: response)
        })
    }
    
    func handleResponse(response : Response) {
        switch response{
            
        case .success(let responseValue):
            
            guard let chats = responseValue as? [Chat] else{ return }
            Alerts.shared.show(alert: .success, message: "success", type: .success)
            self.chats = chats
           
            dataSource = TableViewDataSource(items: chats, height: UITableViewAutomaticDimension, tableView: tableViewDisplayUser, cellIdentifier: "displayUserTableViewCell", configureCellBlock: { (cell, item, indexPath) in
                //Cell for row at indexpath
                
                (cell as? DisplayUserTableViewCell)?.chat = chats[indexPath.row]
                
            }, aRowSelectedListener: { (indexPath) in
                //DidSelectRow at index path
                
                
                guard let vc = ChatViewController.instantiate(fromStoryboard: "Main",id: "ChatViewController") else { return }
                self.navigationController?.pushViewController(vc, animated: true)
                
               
                
            }, DidScrollListener: nil)
            tableViewDisplayUser.delegate = dataSource
            tableViewDisplayUser.dataSource = dataSource
            tableViewDisplayUser.reloadData()
            
            
        case .failure(let str):
            Alerts.shared.show(alert: .oops, message: /str.rawValue, type: .error)
        }
    }
}
