//
//  WeatherRepositoryImpl.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

final class WeatherAPIRepositoryImpl: WeatherAPIRepository {
    
    let endPoint = "http://api.openweathermap.org/data/2.5/weather"
    let APIKey =  "0bc9bc2a73fd9644f664cf5f5c5be8d7"
    
    func getLocationWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let urlString = "\(endPoint)?lat=\(String(describing: latitude))&lon=\(String(describing: longitude))&appid=\(APIKey)"

        let request = URLRequest(url: URL(string: urlString)!)

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data!)
                completion(.success(weatherData))
            } catch {
                completion(.failure(NSError(domain: "Unable to parse action", code: 1)))
            }
        })

        task.resume()
        
    }
    

}
