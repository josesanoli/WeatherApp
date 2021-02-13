//
//  WeatherRepositoryImpl.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

final class WeatherAPIRepositoryImpl: WeatherAPIRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getAPILocationWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        let urlString = "\(API_WEATHER_ENDPOINT)?lat=\(String(describing: latitude))&lon=\(String(describing: longitude))&appid=\(API_KEY)"

        let request = URLRequest(url: URL(string: urlString)!)
        
        networkService.request(request: request, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let weatherCode:WeatherAPIResponseCode = try decoder.decode(WeatherAPIResponseCode.self, from: data!)
                    if weatherCode.cod != 200 {
                        let apiMessage: WeatherAPIResponseMessage? = try? decoder.decode(WeatherAPIResponseMessage.self, from: data!)
                        completion(.failure(.error(statusCode: weatherCode.cod, message: apiMessage?.message)))
                    } else {
                        let weatherData = try decoder.decode(WeatherResponse.self, from: data!)
                        completion(.success(weatherData))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
    }
    

}
