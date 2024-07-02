//
//  BaseVC.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2019 brightsword. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseVC: UIViewController {
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Alert Popup
    func alertMessagePopup(msg: String){
        // create the alert
        let alert = UIAlertController(title: constants.alert.rawValue, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        let yes = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
    }
    
    func successAlertMessagePopup(msg: String){
        // create the alert
        let alert = UIAlertController(title: constants.alert.rawValue, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        let yes = UIAlertAction(title: "OK", style: .default, handler: { action in
            
        })
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension BaseVC: NVActivityIndicatorViewable{
    //MARK: -------- Loader Animation Methods -----------
    func showLoader(){
        startAnimating(CGSize(width: 40, height: 40), message: "", messageFont: nil, type: NVActivityIndicatorType.lineSpinFadeLoader, color:Utilities.colorWithHexString(hex: themeColor), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: Utilities.colorWithHexString(hex: themeColor))
    }
    
    func showLoaderWithMessage(msg: String){
        startAnimating(CGSize(width: 40, height: 40), message: msg, messageFont: nil, type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: Utilities.colorWithHexString(hex: themeColor))
    }
    
    func hideLoader(){
        stopAnimating()
    }
}
