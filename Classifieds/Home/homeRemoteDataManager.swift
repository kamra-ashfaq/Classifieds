//
//  homeRemoteDataManager.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Foundation
import Alamofire
import Reachability
import ObjectMapper

class homeRemoteDataManager: NSObject {
    
}

extension homeRemoteDataManager: homeRemoteDataManagerType {
    
    func getClassifieds(completion: @escaping (ServiceResult<resultEntity>) -> Void) {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            completion(.failure(error: "Network Unreachable"))
        } else {
            let endpoint = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
            Alamofire.request(endpoint).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    let success =  Mapper<resultEntity>().map(JSON: json as! [String : Any])
                    completion(.success(responseObject: success!))
                case .failure(let err):
                    completion(.failure(error: err.localizedDescription))
                }
            })
        }
    }
    
}
