//  HEXExtension.swift
//  Demo
//
//  Created by Anastasia on 15.03.2022.
//

import UIKit

public protocol HEXDelegate {
    static func HEXColor(color: String, alpha: CGFloat) -> UIColor
}

extension UIColor: HEXDelegate {
    public static func HEXColor(color: String, alpha: CGFloat = 1) -> UIColor {
        if (color.count != 6) {
            return UIColor.black
        }

        var colorInRGB: UInt64 = 0
        Scanner(string: color.uppercased()).scanHexInt64(&colorInRGB)

        return UIColor(
            red: CGFloat((colorInRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((colorInRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(colorInRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

import Foundation
