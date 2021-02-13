//
//  FetchWeatherUseCase.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

protocol FetchWeatherUseCase {
    func getLocationWeather(requestValue: LocationCoordinates,
                            completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

final class FetchWeatherUseCaseImpl: FetchWeatherUseCase {
    
    
    private let fetchWeatherRepository: WeatherAPIRepository
    
    init(fetchWeatherRepository: WeatherAPIRepository) {
        self.fetchWeatherRepository = fetchWeatherRepository
    }
    
    func getLocationWeather(requestValue: LocationCoordinates, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        return fetchWeatherRepository.getLocationWeather(latitude: requestValue.latitude,
                                                longitude: requestValue.longitude,
                                                completion: { result in
            completion(result)
        })
    }
}
