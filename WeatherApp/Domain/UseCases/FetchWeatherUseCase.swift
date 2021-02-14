//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

protocol FetchWeatherUseCase {
    func getLocationWeather(requestValue: LocationCoordinates,
                            completion: @escaping (Result<WeatherData, NetworkError>) -> Void)
}

final class FetchWeatherUseCaseImpl: FetchWeatherUseCase {
    
    
    private let fetchWeatherRepository: WeatherAPIRepository
    
    init(fetchWeatherRepository: WeatherAPIRepository) {
        self.fetchWeatherRepository = fetchWeatherRepository
    }
    
    func getLocationWeather(requestValue: LocationCoordinates, completion: @escaping (Result<WeatherData, NetworkError>) -> Void) {
        return fetchWeatherRepository.getAPILocationWeather(latitude: requestValue.latitude, longitude: requestValue.longitude, completion: { result in
            switch result {
            case .success(let response):
                let weatherData = WeatherData (lon: response.coord.lon,
                                               lat: response.coord.lat,
                                               description: response.weather[0].description,
                                               icon: response.weather[0].icon,
                                               temp: response.main.temp,
                                               humidity: response.main.humidity,
                                               windSpeed: response.wind.speed,
                                               clouds: response.clouds.all,
                                               country: response.sys.country,
                                               city: response.name,
                                               pressure: response.main.pressure)
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
