//
//  WeatherRepositoryImpl.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

final class WeatherAPIRepositoryImpl: WeatherAPIRepository {
    
    func getLocationWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        let urlString = "\(API_WEATHER_ENDPOINT)?lat=\(String(describing: latitude))&lon=\(String(describing: longitude))&appid=\(API_KEY)"

        let request = URLRequest(url: URL(string: urlString)!)
//        do {
//            let urlRequest = try endpoint.urlRequest(with: config)
//            return request(request: urlRequest, completion: completion)
//        } catch {
//            completion(.failure(.urlGeneration))
//            return nil
//        }
        let networkService = NetworkService()
        
        networkService.request(request: request, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherResponse.self, from: data!)
                    completion(.success(weatherData))
                } catch {
                    print(error)
                    completion(.failure(.jsonError))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        })
        
        
        
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, requestError -> Void in
//            if let requestError = requestError {
//                var error: NetworkError
//                if let response = response as? HTTPURLResponse {
//                    error = .error(statusCode: response.statusCode, data: data)
//                } else {
//                    error = self.resolve(error: requestError)
//                }
//
//                completion(.failure(error))
//            } else {
//                do {
//                    let decoder = JSONDecoder()
//                    let weatherData = try decoder.decode(WeatherResponse.self, from: data!)
//                    completion(.success(weatherData))
//                } catch {
//                    print(error)
//                    completion(.failure(NSError(domain: "Unable to parse action", code: 1)))
//                }
//            }
//        })
//
//        task.resume()
        
    }
    

}
