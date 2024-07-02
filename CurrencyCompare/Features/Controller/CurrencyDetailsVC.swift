//
//  CurrencyDetailsVC.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import UIKit
import GoogleSignIn
import SwiftyJSON

class CurrencyDetailsVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet var tblView: UITableView!
    @IBOutlet var lblBaseCurrency: UILabel!
    @IBOutlet var tblViewHeight: NSLayoutConstraint!
    
    //MARK:- Variables
    let tblViewDefaultHeight = 45
    var baseCurrency = ""
    var currencyArray: [String] = [String]()
    var ratesArray: [String] = [String]()
    var existingCurrency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("currency array is ", currencyArray)
        print("base currency is ", baseCurrency)
        
        checkCurrencyDetails()
        
    }
    
    //MARK:- Action methods
    @IBAction func btnRefreshClick(_ sender: UIButton) {
        lblBaseCurrency.text = baseCurrency + constants.value.rawValue + baseCurrency
        let results = fetchFromCoreData()
        if results.count > 0{
            let data = results[0]
            existingCurrency = (data[CoreData.compare_currency.rawValue] ?? "")
            currencyCompareApi(baseCurr: baseCurrency, currencyCompare: existingCurrency)
        }
    }
    
    @IBAction func btnEditBaseCurrencyClick(_ sender: UIButton) {
        gotoEditBaseCurrency()
    }
    
    @IBAction func btnAddCurrencyClick(_ sender: UIButton) {
        gotoCompareCurrency()
    }
    
    @IBAction func btnLogoutClick(_ sender: UIButton) {
        logoutPopup()
    }
    
    //MARK:- Redirection methods
    func gotoEditBaseCurrency(){
        let vc: SelectBaseVC = Utilities.viewController(name: "SelectBaseVC", onStoryboard: Storyboard.currency.rawValue) as! SelectBaseVC
        vc.isFromEditCurrency = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoCompareCurrency(){
        let vc: CurrecnyCompareVC = Utilities.viewController(name: "CurrecnyCompareVC", onStoryboard: Storyboard.currency.rawValue) as! CurrecnyCompareVC
        vc.isFromAddMoreCurrency = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Normal methods
    func checkCurrencyDetails(){
        if baseCurrency != "" && currencyArray.count > 0{
            if deleteCoreData() {
                //new record
                if saveToCoreData(home_currency: baseCurrency, compare_currency: currencyArray.joined(separator: ",")){
                    print("saved to core data successfully")
                    lblBaseCurrency.text = baseCurrency + constants.value.rawValue + baseCurrency
                    existingCurrency = currencyArray.joined(separator: ",")
                    currencyCompareApi(baseCurr: baseCurrency, currencyCompare: existingCurrency)
                }else{
                    print("failed to save to coredata")
                }
            }
        }else{
            let results = fetchFromCoreData()
            if results.count > 0 {
                //already exists
                let data = results[0]
                if currencyArray.count > 0{
                    //is from add more currency
                    existingCurrency = (data[CoreData.compare_currency.rawValue] ?? "") + "," + currencyArray.joined(separator: ",")
                    if updateCoreData(home_currency: "", compare_currency: existingCurrency) {
                        //updated successfully
                        baseCurrency = (data[CoreData.home_currency.rawValue] ?? "")
                        lblBaseCurrency.text = baseCurrency + constants.value.rawValue + baseCurrency
                        currencyCompareApi(baseCurr: baseCurrency, currencyCompare: existingCurrency)
                    }else{
                        //update failed
                    }
                }else{
                    //from edit base currency
                    if updateCoreData(home_currency: baseCurrency, compare_currency: "") {
                        //updated successfully
                        lblBaseCurrency.text = baseCurrency + constants.value.rawValue + baseCurrency
                        existingCurrency = (data[CoreData.compare_currency.rawValue] ?? "")
                        currencyCompareApi(baseCurr: baseCurrency, currencyCompare: existingCurrency)
                    }else{
                        //update failed
                    }
                }
            }else{
                //new record
                if saveToCoreData(home_currency: baseCurrency, compare_currency: currencyArray.joined(separator: ",")){
                    print("saved to core data successfully")
                    lblBaseCurrency.text = baseCurrency + constants.value.rawValue + baseCurrency
                    existingCurrency = currencyArray.joined(separator: ",")
                    currencyCompareApi(baseCurr: baseCurrency, currencyCompare: existingCurrency)
                }else{
                    print("failed to save to coredata")
                }
            }
        }
    }
    
    func loadData(response: JSON){
        let arr = response.dictionaryObject
        print("rates array ", arr as Any)
        self.ratesArray.removeAll()
        for (key, value) in arr! {
            let currency = Utilities.replaceStrWithString(mainStr: key, str1: "\"", str2: "")
            let currencyValue = String(format: "%.2f", value as! Double)
            self.ratesArray.append("\(currency) Value: \(currencyValue)")
        }
        print("rates array ", self.ratesArray)
        tblViewHeight.constant = CGFloat(self.ratesArray.count * tblViewDefaultHeight)
        tblView.reloadData()
    }
    
    func logout(){
        USERDEFAULTS.set(false, forKey: UserDefaultsEnums.isloggedin.rawValue)
        USERDEFAULTS.synchronize()
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().disconnect()
        SceneDelegateInstance.gotoLogin(transition : true)
        
        //To logout from google, need to do it manually
        //Searched for the code, but no support found
        /* Login process should redirect to a page with existed login account (if any) or Use another account options after tapped GIDSignInButton, but now that page is gone once you have signed in succeed.
         There are 2 workarounds can bring that page back for now:
         - Clear Website Data of Safari in settings
         - Install another App need Google account and log in with new account (e.g. Gmail, Google drive...)
         
         https://github.com/googlesamples/google-services/issues/326
         */
        
    }
    
    //MARK:- Alert Popup
    func logoutPopup(){
        // create the alert
        let alert = UIAlertController(title: constants.alert.rawValue, message: constants.sure_logout.rawValue, preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.logout()
        })
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(no)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Api methods
    func currencyCompareApi(baseCurr: String, currencyCompare: String) {
        
        let currencyUrl = url + base + baseCurr + symbols + currencyCompare
        
        self.showLoader()
        
        AlamofireClass.alamofireGetMethod(.get, url: currencyUrl, Header: [:], refreshControl: UIRefreshControl(), loadMoreSpinner: UIActivityIndicatorView(), handler: { (response) in
            
            self.hideLoader()
            
            let data = JSON(response)
            
            if data != JSON.null {
                //print("currency response ", data)
                if !(data["rates"] == JSON.null) {
                    let ratesJson = JSON(data["rates"])
                    self.loadData(response: ratesJson)
                }else{
                    self.alertMessagePopup(msg: data["error"].description + constants.change_base_currency.rawValue)
                }
                
            }
        }) { (error) in
            self.hideLoader()
            if error.code == -1009 { //no internet connection
                self.alertMessagePopup(msg: ErrorMessages.internet_down.rawValue)
            }else{ //something else
                self.alertMessagePopup(msg: error.localizedDescription)
            }
            print(error.localizedDescription)
        }
    }
    
}

extension CurrencyDetailsVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TodaysValueTVCell = tableView.dequeueReusableCell(withIdentifier: "TodaysValueTVCell", for: indexPath) as! TodaysValueTVCell
        
        cell.lblCurrencyValue.text = ratesArray[indexPath.row]
        
        return cell
    }
    
    
}
