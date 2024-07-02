//
//  Utilities.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import Foundation
import UIKit

class Utilities{
    //MARK: -------- Go to view controller -----------
    class func viewController(name: String, onStoryboard storyboardName: String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name) as UIViewController
    }
    
    //MARK: ------- Remove spaces in a text corners -----------
    class func trimWhiteSpaces(text : String)-> String
    {
        return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as String
    }
    
    //MARK: ------- Replace string with another string -----------
    class func replaceStrWithString(mainStr: String, str1: String, str2: String) -> String{
        return mainStr.replacingOccurrences(of: str1, with: str2)
    }
    
    //MARK: --------- Convert hex color string to uicolor --------
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}


@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}


