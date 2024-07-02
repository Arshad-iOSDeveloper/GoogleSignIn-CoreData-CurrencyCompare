//
//  CurrecnyCompareVC.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import UIKit

class CurrecnyCompareVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet var tblView: UITableView!
    @IBOutlet var tblViewHeight: NSLayoutConstraint!
    @IBOutlet var lblBaseCurrency: UILabel!
    
    //MARK:- Variables
    let tblViewDefaultHeight = 45
    var baseCurrency = ""
    var currencyArray: [String] = [String]()
    var isFromAddMoreCurrency = false
    var CurrencyCompare = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAlreadyExistingCurrency()
    }
    
    //MARK:- Normal methods
    func checkAlreadyExistingCurrency(){
        if isFromAddMoreCurrency {
            let results = fetchFromCoreData()
            if results.count > 0{
                let data = results[0]
                baseCurrency = (data[CoreData.home_currency.rawValue] ?? "")
                CurrencyCompare = (data[CoreData.compare_currency.rawValue] ?? "")
            }
        }
        
        lblBaseCurrency.text = constants.base_currency.rawValue + baseCurrency
        currencyArray.append("")
        tblViewHeight.constant = CGFloat(currencyArray.count * tblViewDefaultHeight)
        tblView.reloadData()
    }
    
    func loadData(){
        tblViewHeight.constant = CGFloat(currencyArray.count * tblViewDefaultHeight)
        tblView.reloadData()
    }
    
    //MARK:- Action methods
    @IBAction func btnNextClick(_ sender: UIButton) {
        view.endEditing(true)
        
        let cell = tblView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddCurrencyTVCell
        if(cell != nil)
        {
            if validation(currency: cell!.txtEnterCurrency.text ?? "") {
                print("Currency added")
                self.currencyArray.append(cell!.txtEnterCurrency.text!)
                self.gotoCurrencyDetails()
            }
        }
    }
    
    //MARK:- Redirection methods
    func gotoCurrencyDetails(){
        let vc: CurrencyDetailsVC = Utilities.viewController(name: "CurrencyDetailsVC", onStoryboard: Storyboard.currency.rawValue) as! CurrencyDetailsVC
        currencyArray.remove(at: 0)//because it is emoty string
        if isFromAddMoreCurrency {
            vc.baseCurrency = ""
        }else{
            vc.baseCurrency = baseCurrency
        }
        vc.currencyArray = currencyArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CurrecnyCompareVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AddCurrencyTVCell = tableView.dequeueReusableCell(withIdentifier: "AddCurrencyTVCell", for: indexPath) as! AddCurrencyTVCell
        
        if currencyArray[indexPath.row] != "" {
            cell.txtEnterCurrency.text = currencyArray[indexPath.row]
            cell.btnAdd.isHidden = true
            cell.txtEnterCurrency.isUserInteractionEnabled = false
        }else{
            cell.txtEnterCurrency.text = ""
            cell.btnAdd.isHidden = false
            cell.txtEnterCurrency.isUserInteractionEnabled = true
        }
        
        cell.btnAdd.tag = indexPath.row
        cell.btnAdd.addTarget(self, action: #selector(btnAddClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnAddClicked(sender: UIButton){
        view.endEditing(true)
        let btnEmailTag = sender.tag
        let cell = tblView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? AddCurrencyTVCell
        print(btnEmailTag)
        
        if(cell != nil)
        {
            if validation(currency: cell!.txtEnterCurrency.text ?? "") {
                print("Currency added")
                self.currencyArray.append(cell!.txtEnterCurrency.text!)
                self.loadData()
            }
        }
    }
    
    //MARK:- Validations
    func validation(currency: String) -> Bool {
        if (Utilities.trimWhiteSpaces(text: currency).isEmpty) {
            self.alertMessagePopup(msg: constants.compare_currency_empty.rawValue)
            return false
        }else if CurrencyCompare.contains(currency){
            self.alertMessagePopup(msg: constants.wrong_currency.rawValue)
            return false
        }
        return true
    }
    
}
