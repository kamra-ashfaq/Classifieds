//
//  homeRouter.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Swinject
import UIKit

class homeRouter {
    
    private let container: Container?
    
    init(container: Container) {
        self.container = container
    }
    
}

// MARK: - homeRouterType

extension homeRouter: homeRouterType {
    
    func presentHomeViewController(in window: UIWindow) {
        guard let controller = container?.resolve(homeViewType.self) as? homeViewController else { return }
        let rootViewController = UINavigationController(rootViewController: controller)
        rootViewController.navigationBar.isHidden = true
        window.makeKeyAndVisible()
        window.backgroundColor = Palette.white.color
        window.rootViewController = rootViewController
    }
    
}


