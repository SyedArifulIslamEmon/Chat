//
//  HTTPClient.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 04/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import Foundation
import Alamofire

typealias HttpClientSuccess = (Any?) -> ()
typealias HttpClientFailure = (String) -> ()

class HTTPClient {
    
    func JSONObjectWithData(data: NSData) -> Any? {
        do { return try JSONSerialization.jsonObject(with: data as Data, options: []) }
        catch { return .none }
    }
    
    func postRequest(withApi api : Router  , success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure ){
        
        guard let params = api.parameters else { return}
        let fullPath = api.baseURL + api.route
        let method = api.method
        print(fullPath)
        print(params)
        Alamofire.request(fullPath, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
        
    }
    
    func postRequestWithImages(withApi api : Router,images : [UIImage]?, success : @escaping HttpClientSuccess , failure : @escaping HttpClientFailure){
        
        guard let params = api.parameters else {failure("empty"); return}
        let fullPath = api.baseURL + api.route
        print(fullPath)
        print(params)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let arrayImages = images{
                for (i, image) in arrayImages.enumerated() {
                    
                    guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
                        return }
            
                    multipartFormData.append(imageData, withName: "photo\(i+1)", fileName: "photo\(i+1)", mimeType: "image/jpg")
                }
            }

            for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: fullPath) { (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        success(data)
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
