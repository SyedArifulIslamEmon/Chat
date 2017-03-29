//
//  APIManager.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//


import Foundation
import SwiftyJSON
import NVActivityIndicatorView

class APIManager : UIViewController, NVActivityIndicatorViewable{
    
    typealias Completion = (Response) -> ()
    static let shared = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , completion : @escaping Completion )  {
        
        if isLoaderNeeded(api: api) {
            startAnimating(nil, message: nil, messageFont: nil, type: .lineScalePulseOutRapid, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
        }
        
        httpClient.postRequest(withApi: api, success: {[weak self] (data) in
            self?.stopAnimating()
            
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            
            let json = JSON(response)
            print(json)
            if json[APIConstants.status].stringValue == Validate.invalidAccessToken.rawValue{
               
                    self?.tokenExpired()
                               return
            }
            
            let responseType = Validate(rawValue: json[APIConstants.status].stringValue) ?? .failure
            if responseType == Validate.success{
                let object : Any?
                object = api.handle(parameters: json)
                completion(Response.success(object))
                return
            }
            else{
                completion(Response.failure(.failure))
            }
            }, failure: {[weak self] (message) in
                self?.stopAnimating()
                completion(Response.failure(.failure))
        })
    }
    
    func request (withImages api : Router , images : [UIImage]?  , completion : @escaping Completion )  {
        
        if isLoaderNeeded(api: api) {
            startAnimating(nil, message: nil, messageFont: nil, type: .lineScalePulseOutRapid, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil)
        }
        
        httpClient.postRequestWithImages(withApi: api, images: images, success: {[weak self] (data) in
            
            self?.stopAnimating()
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            let json = JSON(response)
            print(json)
            if json[APIConstants.status].stringValue == Validate.invalidAccessToken.rawValue{
              
                    self?.tokenExpired()
                
                return
            }
            
            let responseType = Validate(rawValue: json[APIConstants.status].stringValue) ?? .failure
            
            switch responseType {
            case .success:
                let object : Any?
                object = api.handle(parameters: json)
                completion(Response.success(object))
                
            case .failure():
                completion(Response.failure(.failure))
                
            default : break
            }
            }, failure: {[weak self] (message) in
                self?.stopAnimating()
                completion(Response.failure(.failure))
        })
    }
    
    func tokenExpired(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.logout()
    }
    
    func isLoaderNeeded(api : Router) -> Bool{
        switch api.route {
            case APIConstants.polling : return false
            case APIConstants.sendMessage : return false
            default: return true
        }
    }
}
