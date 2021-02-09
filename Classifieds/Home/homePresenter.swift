//
//  homePresenter.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit
import SDWebImage

class homePresenter: NSObject {
    
    private weak var view: homeViewType?
    private var router: homeRouterType?
    private var interactor: homeInteractorType?
    
    lazy var dataSource = [homeEntity]()
    
    required init(view: homeViewType, router: homeRouterType, interactor: homeInteractorType) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension homePresenter: homePresenterType {
    
    func viewDidLoad() {
    }
    
    func getClassifiedsList(completion: @escaping ((ServiceResult<resultEntity>) -> Void)) {
        
        interactor?.callClassifiedsEndpoint(completion: { (result) in
            switch result {
            case .success(let responseObj): do {
                self.dataSource = responseObj.results!
                completion(.success(responseObject: responseObj))
                }
            case .failure(let error): do {
                self.view?.showErrorAlertWith(title: "Error", message: error)
                completion(.failure(error: error))
                }
            }
        })
        
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        self.router?.presentDetailViewController(sender: self.view as! UIViewController, selectedRow: self.dataSource[indexPath.row])
    }

}

// MARK: - UITableViewDatasource

extension homePresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCell.cellID) as? homeTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = self.dataSource[indexPath.row].name
        cell.priceLabel.text = self.dataSource[indexPath.row].price
        cell.createdLabel.text = self.dataSource[indexPath.row].created_at!
        cell.thumbnailImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.thumbnailImageView.sd_setImage(with: URL(string: self.dataSource[indexPath.row].imageThumbnail?[0] ?? ""), placeholderImage: UIImage(named: "LaunchScreen"))
        return cell
    }
    
}
