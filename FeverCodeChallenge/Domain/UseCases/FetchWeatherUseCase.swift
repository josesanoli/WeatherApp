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
    
    
    private let repository: WeatherAPIRepository
    
    init(repository: WeatherAPIRepository) {
        self.repository = repository
    }
    
    func getLocationWeather(requestValue: LocationCoordinates, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        return repository.getLocationWeather(latitude: requestValue.latitude,
                                                longitude: requestValue.longitude,
                                                completion: { result in


            completion(result)
        })
    }
    

}
