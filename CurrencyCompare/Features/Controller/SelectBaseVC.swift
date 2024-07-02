//
//  SelectBaseVC.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import UIKit

class SelectBaseVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet var txtBaseCurrency: UITextField!
    
    //MARK:- Variables
    var isFromEditCurrency = false
    var CurrencyCompare = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAlreadyExistingCurrency()
    }
    
    //MARK:- Normal methods
    func checkAlreadyExistingCurrency(){
        if isFromEditCurrency {
            let results = fetchFromCoreData()
            if results.count > 0{
                let data = results[0]
                CurrencyCompare = (data[CoreData.compare_currency.rawValue] ?? "")
            }
        }
    }
    
    //MARK:- Validation Methods
    func validation() -> Bool {
        if (Utilities.trimWhiteSpaces(text: txtBaseCurrency.text!).isEmpty) {
            self.alertMessagePopup(msg: constants.base_currency_empty.rawValue)
            return false
        }/*else if CurrencyCompare.contains(txtBaseCurrency.text!){
            self.alertMessagePopup(msg: constants.wrong_currency.rawValue)
            return false
        } */
        return true
    }
    
    //MARK:- Action methods
    @IBAction func btnNextClick(_ sender: UIButton) {
        view.endEditing(true)
        if validation() {
            if !isFromEditCurrency {
                //goto enter comparision currency
                gotoCompareCurrency()
            }else{
                //goto Currency details screen
                gotoCurrencyDetails()
            }
        }
    }
    
    //MARK:- Redirection methods
    func gotoCompareCurrency(){
        let vc: CurrecnyCompareVC = Utilities.viewController(name: "CurrecnyCompareVC", onStoryboard: Storyboard.currency.rawValue) as! CurrecnyCompareVC
        vc.baseCurrency = txtBaseCurrency.text ?? "INR"
        vc.isFromAddMoreCurrency = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoCurrencyDetails(){
        let vc: CurrencyDetailsVC = Utilities.viewController(name: "CurrencyDetailsVC", onStoryboard: Storyboard.currency.rawValue) as! CurrencyDetailsVC
        vc.baseCurrency = txtBaseCurrency.text ?? "INR"
        vc.currencyArray = [String]()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
