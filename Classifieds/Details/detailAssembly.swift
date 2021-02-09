//
//  detailAssembly.swift
//  Classifieds
//
//  Created by kamran on 09/02/2021.
//

import Swinject

class detailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(detailViewType.self) { (_) in
            detailViewController()
            }.initCompleted { (resolver, CV) in
                CV.presenter = resolver.resolve(detailPresenterType.self)!
        }
        
        container.register(detailPresenterType.self) { (resolver) in
            let view = resolver.resolve(detailViewType.self)!
            return detailPresenter(view: view)
        }
        
    }
    
}
