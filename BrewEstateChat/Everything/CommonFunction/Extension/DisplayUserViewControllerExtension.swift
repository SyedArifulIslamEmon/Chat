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
            
            guard let messages = responseValue as? Messages else{ fatalError()}
            Alerts.shared.show(alert: .success, message: "success", type: .success)
            
            guard  let itemCount = messages.dataMessage else {
                fatalError()
            }
           
            dataSourceTableViewDisplayUser = TableViewDataSource(items: itemCount, height: UITableViewAutomaticDimension, tableView: tableViewDisplayUser, cellIdentifier: "displayUserTableViewCell", configureCellBlock: { (cell, item, indexPath) in
                //Cell for row at indexpath
                
                (cell as? DisplayUserTableViewCell)?.lblUserName.text = /messages.dataMessage?[indexPath.row].name
                (cell as? DisplayUserTableViewCell)?.lblLastMessage.text = /messages.dataMessage?[indexPath.row].name
                (cell as? DisplayUserTableViewCell)?.lblLastMessageTime.text = /messages.dataMessage?[indexPath.row].name
                
            }, aRowSelectedListener: { (indexPath) in
                //DidSelectRow at index path
                
                Utility.functions.startAnimating(nil, message: nil, messageFont: nil, type: .lineScalePulseOutRapid, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
                
                guard let vc = ChatViewController.instantiate(fromStoryboard: "Main",id: "ChatViewController") else { return }
                self.navigationController?.pushViewController(vc, animated: true)
                
                Utility.functions.stopAnimating()
                
            }, DidScrollListener: nil)
            tableViewDisplayUser.delegate = dataSourceTableViewDisplayUser
            tableViewDisplayUser.dataSource = dataSourceTableViewDisplayUser
            tableViewDisplayUser.reloadData()
            
            
        case .failure(let str):
            Alerts.shared.show(alert: .oops, message: /str.rawValue, type: .error)
        }
    }
}
