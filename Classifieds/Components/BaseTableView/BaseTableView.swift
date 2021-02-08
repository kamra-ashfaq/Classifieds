//
//  BaseTableView.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit

class BaseTableView: UITableView {

    // MARK: - Initializers
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
    }
    
    // MARK: - Setup
    
    private func setupTableView() {
        frame = .zero
        bounces = true
        estimatedRowHeight = 120
        separatorInset = .zero
        allowsSelection = true
    }

}

