//
//  AlamofireClass.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2018 brightsword. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlamofireClass: NSObject {
    
    typealias CompletionHandler = (_ response:AnyObject) -> Void
    typealias ErrorHandler = (_ error : NSError) -> Void
    typealias ProgressValue = (_ progressValue : Float) -> Void
    typealias CompletionHandlerWithStatusCode = (_ response:AnyObject, _ statusCode : Int) -> Void
    typealias ErrorHandlerWithStatusCode = (_ error : NSError, _ statusCode : Int) -> Void
    
    //MARK: -------- Rest Api Call ------------
    class func alamofireMethodParamAny(_ methods: Alamofire.HTTPMethod , url : URLConvertible , parameters : [String : Any], refreshControl: UIRefreshControl,loadMoreSpinner:UIActivityIndicatorView, showActivityIndicator: Bool = true, handler:@escaping CompletionHandler,errorhandler : @escaping ErrorHandler)
    {
        
        var alamofireManager : Alamofire.SessionManager?
        
        var UrlFinal = ""
        
        do
        {
            try UrlFinal = url.asURL().absoluteString
        }catch{}
        
        let headers: HTTPHeaders = HTTPHeaders()
        
        print(UrlFinal)
        print(headers)
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60 //configuration.httpAdditionalHeaders = header //configuration.requestCachePolicy = .useProtocolCachePolicy
        
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager = Alamofire.SessionManager.default
        
        if kNetworkController.checkNetworkStatus(){
            alamofireManager?.request(UrlFinal, method: methods, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON(queue: nil, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response) in
                
                print(response)
                
                if response.result.isSuccess {
                    if (response.result.value != nil) {
                        if response.response?.statusCode != nil {
                            if response.response?.statusCode == 403 {
                                
                            }else{
                                handler(response.result.value! as AnyObject)
                            }
                        }
                    }
                    
                }else {
                    baseViewObj.hideLoader()
                    errorhandler((response.result.error! as NSError))
                }
            })//.session.finishTasksAndInvalidate()
        }else{
            baseViewObj.hideLoader()
        }
    }
    
    class func alamofireGetMethod(_ methods: Alamofire.HTTPMethod , url : URLConvertible ,Header: [String: String], refreshControl: UIRefreshControl,loadMoreSpinner:UIActivityIndicatorView, showActivityIndicator: Bool = true, handler:@escaping CompletionHandler,errorhandler : @escaping ErrorHandler)
    {
        
        var alamofireManager : Alamofire.SessionManager?
        let headers: HTTPHeaders = HTTPHeaders()
        
        var UrlFinal = ""
        do{
            try UrlFinal = url.asURL().absoluteString
        }catch{}
        
        
        print(UrlFinal)
        print(headers)
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60 //configuration.httpAdditionalHeaders = header //configuration.requestCachePolicy = .useProtocolCachePolicy
        
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager = Alamofire.SessionManager.default
        
        if kNetworkController.checkNetworkStatus(){
            alamofireManager?.request(UrlFinal, method: methods, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON(queue: nil, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response) in
                
                print(response)
                
                if response.result.isSuccess {
                    if (response.result.value != nil) {
                        if response.response?.statusCode != nil {
                            if response.response?.statusCode == 403 {
                                
                            }else{
                                handler(response.result.value! as AnyObject)
                            }
                        }
                    }
                }else {
                    baseViewObj.hideLoader()
                    errorhandler((response.result.error! as NSError))
                }
            })//.session.finishTasksAndInvalidate()
        }else{
            baseViewObj.hideLoader()
            baseViewObj.alertMessagePopup(msg: constants.no_internet.rawValue)
        }
        
    }
}
