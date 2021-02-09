//
//  detailViewController.swift
//  Classifieds
//
//  Created by kamran on 09/02/2021.
//

import UIKit
import SnapKit
import SDWebImage

class detailViewController: UIViewController {
    
    var presenter: detailPresenterType?
    var details: homeEntity?
    
    private let navigationView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "navigationView"
        view.tag = Tag.navigationView.rawValue
        return view
    }()
    
    public var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleLarge.font
        label.textColor = Palette.magenta.color
        label.tag = Tag.priceLabel.rawValue
        return label
    }()
    
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleSemiLarge.font
        label.textColor = Palette.black.color
        label.tag = Tag.nameLabel.rawValue
        return label
    }()
    
    public var createdLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.bodyItalic.font
        label.textColor = Palette.magenta.color
        label.tag = Tag.createdLabel.rawValue
        return label
    }()
    
    public let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LaunchScreen"))
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "thumbnailImageView"
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.tag = Tag.thumbnailImageView.rawValue
        return imageView
    }()
 
    public let itemImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LaunchScreen"))
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "itemImageView"
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        imageView.tag = Tag.itemImageView.rawValue
        return imageView
    }()
    
    // MARK: - Life Cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        priceLabel.text = self.details?.price
        nameLabel.text = self.details?.name
        createdLabel.text = self.details?.created_at
        
        itemImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        itemImageView.sd_setImage(with: URL(string: (self.details?.imageUrl![0])!), placeholderImage: UIImage(named: "LaunchScreen"))
        
        thumbnailImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        thumbnailImageView.sd_setImage(with: URL(string: (self.details?.imageThumbnail![0])!), placeholderImage: UIImage(named: "LaunchScreen"))
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRegularConstraints()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - Setup Views
    func setupViews() {
        view.addSubview(navigationView)
        view.addSubview(priceLabel)
        view.addSubview(nameLabel)
        view.addSubview(itemImageView)
        view.addSubview(thumbnailImageView)
        view.addSubview(createdLabel)
  
    }
    
    // MARK: -  Regular Constraints
    private func setupRegularConstraints() {
        
        navigationView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.right.equalToSuperview()
            make.height.equalTo(25)
        }
        
        itemImageView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.height.equalTo(375 / 667 * UIScreen.main.bounds.height)
        }
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(itemImageView.snp.bottom).offset(5)
            make.left.equalTo(itemImageView.snp.left)
            make.width.equalTo(100 / 375 * UIScreen.main.bounds.width)
            make.height.equalTo(100 / 667 * UIScreen.main.bounds.height)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.top)
            make.left.equalTo(thumbnailImageView.snp.right).offset(5)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.left.equalTo(priceLabel.snp.left)
        }
        
        createdLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalTo(itemImageView.snp.right)
        }
        
    }

    
}
// MARK: DetailViewType

extension detailViewController: detailViewType {
    
    private enum Tag: Int {
        case navigationView = 1
        case priceLabel
        case nameLabel
        case createdLabel
        case thumbnailImageView
        case itemImageView
    }
    
}
