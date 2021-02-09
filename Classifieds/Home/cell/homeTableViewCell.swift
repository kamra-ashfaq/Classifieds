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
    
    public var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleLarge.font
        label.textColor = Palette.magenta.color
        label.tag = 1
        return label
    }()
    
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleSemiLarge.font
        label.textColor = Palette.black.color
        label.tag = 2
        return label
    }()
    
    public var createdLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.bodyItalic.font
        label.textColor = Palette.magenta.color
        label.tag = 3
        return label
    }()
    
    public let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LaunchScreen"))
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "LaunchScreen"
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.tag = 4
        return imageView
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(priceLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(createdLabel)
        contentView.addSubview(thumbnailImageView)
        
        setupRegularConstraints()
    }
    
    private func setupRegularConstraints() {
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(104)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(thumbnailImageView.snp.right).offset(5)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.left.equalTo(thumbnailImageView.snp.right).offset(5)
        }
        
        createdLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-5)
        }
        
    }
    
}

