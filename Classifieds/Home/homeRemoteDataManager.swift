//
//  homeRemoteDataManager.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Foundation
import Alamofire
import Freddy
import Reachability

class homeRemoteDataManager: NSObject {
    
}

extension homeRemoteDataManager: homeRemoteDataManagerType {
    
    func getClassifieds(completion: @escaping (ServiceResult<homeEntity>) -> Void) {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            completion(.failure(error: "Network Unreachable"))
        } else {
            let endpoint = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
            Alamofire.request(endpoint).ClassifiedsResponseJSON { (response) in
                switch response.result {
                case .success(let json):
                    do {
                        let success = try homeEntity(json: json)
                        completion(.success(responseObject: success))
                    } catch let error {
                        completion(.failure(error: "We have encountered an error. Please try again.\n\(error)"))
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let responseJSON = try JSON(data: data)
                            let userError = try responseJSON.getString(at: "error_message")
                            completion(.failure(error: userError))
                        } catch {
                            completion(.failure(error: "Network Unreachable"))
                        }
                    } else {
                        completion(.failure(error: "Network Unreachable"))
                    }
                }
            }
        }
    }
    
}


