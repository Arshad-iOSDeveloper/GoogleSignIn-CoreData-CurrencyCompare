//
//  Enum.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import Foundation
import UIKit

enum constants:String{
    case base_currency_empty = "Please enter base currency"
    case alert = "Alert"
    case compare_currency_empty = "Please enter currency to compare"
    case add_atleast_one = "Add atleast one currency to compare"
    case failed_save = "Failed to save to coredata"
    case saved_successfully = "saved successfully"
    case deleted_successfully = "Deleted successfully"
    case deleted_failed = "Failed to deleted"
    case no_internet = "please check your internet connection"
    case yes_internet = "Internet connection is available"
    case loading_message = "Loading"
    case error = "Error"
    case sure_logout = "Are you sure, want to logout ?"
    case wrong_currency = "Please enter different currency to compare"
    case base_currency = "Base Currency : "
    case value = " Value : 1 "
    case change_base_currency = " ,please change base currency"
}

enum ErrorMessages: String{
    case Internal_Error = "Internal Error"//500
    case Bad_Request = "Bad request, please try again"//400
    case internet_down = "Error connecting. Please use a stronger wifi or use your data connection and try again."//
    case something_went_wrong = "Something went wrong, Please try later"
}

enum CoreData:String{
    case entity = "Currency"
    case CurrencyCompare = "CurrencyCompare"
    case home_currency = "home_currency"
    case compare_currency = "compare_currency"
}

enum Storyboard:String{
    case currency = "currency"
}

enum UserDefaultsEnums:String{
    case isloggedin = "isloggedin"
}
