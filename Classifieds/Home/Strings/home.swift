//
//  home.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Foundation

enum home: String {
    
    case homeTitleText = "TITLE_TEXT"
     
}

extension home: StringLocalizable {
    
    var localized: String {
        return self.rawValue.localized(fromTable: "\(type(of: self))")
    }
    
}

protocol StringLocalizable {
    
    var localized: String { get }
    
}

extension String {
    
    func localized(fromTable table: String) -> String {
        return NSLocalizedString(self, tableName: table, value: "ERROR FOR STRING: \"\(self)\"", comment: "")
    }
    
    mutating func append(string: String) {
        if self.count > 0 {
            self += " and \(string)"
        } else {
            self = string
        }
    }

}
