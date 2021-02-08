//
//  homePresenter.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit
 
class homePresenter: NSObject {
    
    private weak var view: homeViewType?
    private var router: homeRouterType?
    private var interactor: homeInteractorType?
    
    required init(view: homeViewType, router: homeRouterType, interactor: homeInteractorType) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension homePresenter: homePresenterType {
    
    func viewDidLoad() {}
    
    func getClassifiedsList(completion: @escaping ((ServiceResult<homeEntity>) -> Void)) {
        
        interactor?.callClassifiedsEndpoint(completion: { (result) in
            switch result {
            case .success(let responseObj): do {
                completion(.success(responseObject: responseObj))
                }
            case .failure(let error): do {
                self.view?.showErrorAlertWith(title: "Error", message: error)
                completion(.failure(error: error))
                }
            }
        })
        
    }
    
}

// MARK: - UITableViewDatasource

extension homePresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCell.cellID) as? homeTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}
