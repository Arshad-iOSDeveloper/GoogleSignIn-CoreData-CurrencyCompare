//
//  AddCurrencyTVCell.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import UIKit

class AddCurrencyTVCell: UITableViewCell,UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet var txtEnterCurrency: UITextField!
    @IBOutlet var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtEnterCurrency.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
