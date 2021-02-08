//
//  homeAssembly.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Swinject

class homeAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(homeRouterType.self) { (_) in
            return homeRouter(container: container)
        }
        
        container.register(homeViewType.self) { (_) in
            homeViewController()
            }.initCompleted { (resolver, CV) in
                CV.presenter = resolver.resolve(homePresenterType.self)!
        }
        
        container.register(homePresenterType.self) { (resolver) in
            let view = resolver.resolve(homeViewType.self)!
            let router = resolver.resolve(homeRouterType.self)!
            let interactor = resolver.resolve(homeInteractorType.self)!
            return homePresenter(view: view, router: router, interactor: interactor)
        }
        
        container.register(homeInteractorType.self) { (resolver) in
            let remoteDataManager = resolver.resolve(homeRemoteDataManagerType.self)!
        
            return homeInteractor(remoteDataManager: remoteDataManager)
        }
        
        container.register(homeRemoteDataManagerType.self) { (_) in
            return homeRemoteDataManager()
        }
        
    }
    
}

