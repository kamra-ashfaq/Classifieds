//
//  homeInteractor.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

class homeInteractor {
    
    private var remoteDataManager: homeRemoteDataManagerType?
    
    required init(remoteDataManager: homeRemoteDataManagerType) {
            self.remoteDataManager = remoteDataManager
    }

}

// MARK: - homeInteractorType

extension homeInteractor: homeInteractorType {
    
    func callClassifiedsEndpoint(completion: @escaping (ServiceResult<homeEntity>) -> Void) {
        
        remoteDataManager?.getClassifieds(completion: { (result) in
            switch result {
            case .success(let response):
                completion(.success(responseObject: response))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
        
    }
    
}


