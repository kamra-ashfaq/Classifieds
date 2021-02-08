//
//  homeCell.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit
import SnapKit

class homeTableViewCell: UITableViewCell {

    static let cellID = "homeTableViewCell"
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleLarge.font
        label.textColor = Palette.magenta.color
        label.tag = 1
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.bodyItalic.font
        label.textColor = Palette.black.color
        label.tag = 2
        return label
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection != previousTraitCollection else { return }
        
        switch traitCollection.verticalSizeClass {
        case .regular: setupRegularConstraints()
        case .compact, .unspecified: break
        @unknown default: break
        }
    }
    
    private func setupViews() {
        addSubview(priceLabel)
        addSubview(nameLabel)
    }
    
    private func setupRegularConstraints() {
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(15)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.left.equalToSuperview().offset(15)
        }
        
    }
    
}

