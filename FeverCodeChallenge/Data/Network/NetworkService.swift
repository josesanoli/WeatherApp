//
//  NetworkService.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
    case jsonError
}

public final class NetworkService {
    
    public func request(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        })
 
        task.resume()
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
    
}

