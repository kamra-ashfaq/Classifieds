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
    
    func presentDetailViewController(sender: UIViewController, selectedRow: homeEntity) {
        
        let controller = detailViewController()
        controller.details = selectedRow
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut )
        transition.type = CATransitionType.fade
        sender.navigationController?.view.layer.add(transition, forKey: nil)
        
        sender.navigationController?.navigationBar.isHidden = false
        sender.navigationController?.navigationBar.topItem?.title = selectedRow.name
        sender.navigationController?.pushViewController(controller, animated: false)
        
    }
    
}
