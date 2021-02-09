//
//  homeViewController.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit
import SnapKit

class homeViewController: UIViewController {
    
    var presenter: homePresenterType?
    
    private let navigationView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "navigationView"
        view.tag = Tag.navigationView.rawValue
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LaunchScreen"))
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "LaunchScreen-logo"
        imageView.tag = Tag.logoImageView.rawValue
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleXL.font
        label.text = home.homeTitleText.localized
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        label.minimumScaleFactor = 0.25
        label.accessibilityIdentifier = "titleLabel"
        label.tag = Tag.titleLabel.rawValue
        label.textColor =  Palette.cobaltBlue.color
        return label
    }()
    
    private lazy var classifiedTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self.presenter as? UITableViewDataSource
        tableView.accessibilityIdentifier = "searchTableView"
        tableView.tag = Tag.classifiedTableView.rawValue
        tableView.isHidden = false
        tableView.register(homeTableViewCell.self, forCellReuseIdentifier: homeTableViewCell.cellID)
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = Palette.cobaltBlue.color
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Life Cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        presenter?.getClassifiedsList(completion: { (result) in
            switch result {
            case .success(responseObject: _):
                self.classifiedTableView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failure(error: let err):
                self.activityIndicator.stopAnimating()
                self.showErrorAlertWith(title: "Error", message: err)
            }
        })
 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRegularConstraints()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    // MARK: - Setup Views
    func setupViews() {
        view.addSubview(navigationView)
        view.addSubview(titleLabel)
        view.addSubview(logoImageView)
        view.addSubview(classifiedTableView)
        view.addSubview(activityIndicator)
        view.bringSubviewToFront(activityIndicator)
    }
    
    // MARK: -  Regular Constraints
    private func setupRegularConstraints() {
        
        navigationView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.right.equalToSuperview()
            make.height.equalTo(25)
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.height.equalTo(112)
            make.width.equalTo(285)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom)
            make.height.equalTo(35 / 667 * UIScreen.main.bounds.height)
            make.width.equalTo(330 / 375 * UIScreen.main.bounds.width)
        }
        
        classifiedTableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.width.equalTo(335 / 375 * UIScreen.main.bounds.width)
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        
    }
    
}

// MARK: - UITableViewDelegate

extension homeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: HomeViewType

extension homeViewController: homeViewType {
    
    
    func presentErrorNotificationBanner(message: String) {
        // call super class banner if require
    }
    
    func showErrorAlertWith(title: String?, message: String) {
        // call super class alert if require
    }
    
    private enum Tag: Int {
        case navigationView = 1
        case titleLabel
        case logoImageView
        case classifiedTableView
    }
    
}
