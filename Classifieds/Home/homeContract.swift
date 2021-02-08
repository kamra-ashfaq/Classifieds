//
//  homeContract.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import UIKit

protocol homeViewType: class {
    
    var presenter: homePresenterType? { get set }
    func showErrorAlertWith(title: String?, message: String)
    func presentErrorNotificationBanner(message: String)
    
}

protocol homeInteractorType: class {
    func callClassifiedsEndpoint(completion: @escaping (ServiceResult<homeEntity>) -> Void)
}

protocol homePresenterType: class {
    
    func viewDidLoad()
    func getClassifiedsList(completion: @escaping ((ServiceResult<homeEntity>) -> Void))
 
}

protocol homeRouterType: class {
    func presentHomeViewController(sender: UIViewController)
}

protocol homeRemoteDataManagerType: class {
    func getClassifieds(completion: @escaping (ServiceResult<homeEntity>) -> Void)
}


