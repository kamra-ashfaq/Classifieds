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
    
    func presentHomeViewController(sender: UIViewController) {
        guard let controller = self.container?.resolve(homeViewType.self) as? homeViewController else { return }
        sender.navigationController?.navigationItem.hidesBackButton = true
        sender.navigationController?.navigationBar.isHidden = true
        sender.navigationController?.navigationBar.topItem?.title = ""
        sender.navigationController?.pushViewController(controller, animated: false)
        
    }
    
}


