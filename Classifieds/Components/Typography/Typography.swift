//
//  Typography.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit

enum Typography {
    
    case titleXL
    case titleLarge
    case titleSemiLarge
    case bodyItalic
    
    var font: UIFont? {
        switch self {
        case .titleXL: return UIFont(name: "Helvetica Neue", size: 34)
        case .titleLarge: return UIFont(name: "Helvetica Neue", size: 28)
        case .titleSemiLarge: return UIFont(name: "Helvetica Neue", size: 26)
        case .bodyItalic: return UIFont(name: "Helvetica Neue", size: 14)
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .titleXL: return CGFloat(38)
        case .titleLarge: return CGFloat(36)
        case .titleSemiLarge: return CGFloat(34)
        case .bodyItalic: return CGFloat(18)
        }
    }
}
