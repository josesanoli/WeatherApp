//
//  WeatherRepositoryImpl.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

final class WeatherAPIRepositoryImpl: WeatherAPIRepository {
    
    static let endPoint = "api.openweathermap.org/data/2.5/weather"
    
    func getLocationWeather(latitude: Float, logitude: Float, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let testREsponse = WeatherResponse(city: "Test City", description: "Test weather", temp: 20)

        completion(.success(testREsponse))
        //completion(.failure(<#Error#>))
    }
    

}
