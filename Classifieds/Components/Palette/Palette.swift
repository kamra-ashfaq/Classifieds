//
//  Palette.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//


import UIKit

enum Palette {
    
    case black
    case cobaltBlue
    case clear
    case darkPurple
    case magenta

    var color: UIColor {
        switch self {
        case .black: return UIColor.rgb(red: 0, green: 0, blue: 0)
        case .clear: return UIColor.clear
        case .cobaltBlue: return UIColor.rgb(red: 56, green: 84, blue: 143)
        case .darkPurple: return UIColor.rgb(red: 48, green: 35, blue: 174)
        case .magenta: return UIColor.rgb(red: 168, green: 149, blue: 114)
    }
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha!)
    }
}
