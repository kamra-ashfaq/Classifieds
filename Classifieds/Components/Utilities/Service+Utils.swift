//
//  Service+Utils.swift
//  Classifieds
//
//  Created by kamran on 08/02/2021.
//

import Alamofire
import Foundation
import Freddy

enum Result<T> {
    
    case success(T)
    case failure(error: Error)
    
}

enum ServiceResult<T> {
    
    case success(responseObject: T)
    case failure(error: String)
    
}

enum EmptyResult {
    
    case success
    case failure(error: String)
    
}

enum AuthenticationType: String {
    
    case authenticated = "AUTHENTICATED"
    case unAuthenticated = "UNAUTHENTICATED"
    
}

enum ErrorType: String {
    
    case reachability = "REACHABILITY_ERROR"
    case alamoFire = "ALAMOFIRE_ERROR"
    case urlError = "URL_ERROR"
    case errorResponse = "ERROR_RESPONSE"
    case objectMapping = "OBJECT_MAPPING_ERROR"
    case unknownError = "UNKNOWN_ERROR"
    case unAuthenticatedUser = "UNAUTHENTICATED_USER_ERROR"
    
}

enum ClassifiedsError: Error {
    
    case network(error: Error)
    case failure(error: Error?)
    case unknownError(String)
    case unAuthenticatedUser(String)
    
    case objectMappingError(error: Error)
    case alamoFireError(String)
    case urlError(String)
    
    var errorType: ErrorType {
        switch self {
        case .network: return .reachability
        case .failure: return .errorResponse
        case .unAuthenticatedUser: return .unAuthenticatedUser
            
        case .objectMappingError: return .objectMapping
        case .alamoFireError: return .alamoFire
        case .urlError: return .urlError
        default: return .unknownError
        }
    }
}

protocol NetworkResponseHandler {
    
    func parseError(response: DataResponse<Any>) -> ClassifiedsError?
    func verifyStatusCode(in response: DataResponse<Any>) -> Bool
    
}

extension NetworkResponseHandler {
    
    func verifyStatusCode(in response: DataResponse<Any>) -> Bool {
        guard let statusCode = response.response?.statusCode, (200..<300).contains(statusCode) else {
            return false
        }
        return true
    }
    
    func parseError(response: DataResponse<Any>) -> ClassifiedsError? {
        guard case let .failure(error) = response.result else {
            return ClassifiedsError.failure(error: response.result.error!)
        }
        
        var failureError: ClassifiedsError?
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                failureError = ClassifiedsError.alamoFireError("Invalid URL: \(url) - \(error.localizedDescription)")
            case .parameterEncodingFailed(let reason):
                failureError = ClassifiedsError.alamoFireError("Parameter encoding failed: \(error.localizedDescription) Failure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                failureError = ClassifiedsError.alamoFireError("Multipart encoding failed: \(error.localizedDescription) Failure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    failureError = ClassifiedsError.alamoFireError("Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    failureError = ClassifiedsError.alamoFireError("Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    failureError = ClassifiedsError.alamoFireError("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    failureError = ClassifiedsError.alamoFireError("Response status code was unacceptable: \(code)")
                }
            case .responseSerializationFailed(let reason):
                failureError = ClassifiedsError.alamoFireError("Response serialization failed: \(error.localizedDescription) Failure Reason: \(reason)")
            }
        } else if let error = error as? URLError {
            failureError = ClassifiedsError.urlError("URLError occurred: \(error)")
        } else {
            failureError = ClassifiedsError.unknownError("Unknown error: \(error)")
        }
        
        return failureError
    }
    
}

extension DataRequest {
    
    static func jsonResponseSerializer() -> DataResponseSerializer<JSON> {
        return DataResponseSerializer(serializeResponse: { (_, response, data, error) in
            guard error == nil else {
                return .failure(ClassifiedsError.failure(error: error))
            }
            
            guard let statusCode = response?.statusCode, (200..<300).contains(statusCode) else {
                return .failure(ClassifiedsError.failure(error: error))
            }
            
            let result = Request.serializeResponseData(response: response, data: data, error: error)
            
            guard case .success = result else {
                return .failure(ClassifiedsError.failure(error: error))
            }
            
            do {
                let json = try JSON(data: result.value!)
                return .success(json)
            } catch let error {
                return .failure(ClassifiedsError.failure(error: error))
            }
        })
    }
    
    @discardableResult
    func ClassifiedsResponseJSON(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<JSON>) -> Void) -> Self {
        return validate(statusCode: 200..<300)
            .validate(contentType: ["application/json; charset=UTF-8"]).response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func ClassifiedsResponseData(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Data>) -> Void) -> Self {
        return validate(statusCode: 200..<300).validate(contentType: ["application/json; charset=UTF-8"]).responseData(queue: queue, completionHandler: completionHandler)
    }
    
}

