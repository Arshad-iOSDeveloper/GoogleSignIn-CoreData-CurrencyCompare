//
//  Extensions.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
