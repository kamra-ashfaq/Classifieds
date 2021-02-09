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
    func callClassifiedsEndpoint(completion: @escaping (ServiceResult<resultEntity>) -> Void)
}

protocol homePresenterType: class {
    
    func viewDidLoad()
    func getClassifiedsList(completion: @escaping ((ServiceResult<resultEntity>) -> Void))
    func didSelectRowAt(indexPath: IndexPath)
}

protocol homeRouterType: class {
    func presentHomeViewController(in window: UIWindow)
    func presentDetailViewController(sender: UIViewController, selectedRow: homeEntity)
}

protocol homeRemoteDataManagerType: class {
    func getClassifieds(completion: @escaping (ServiceResult<resultEntity>) -> Void)
}


