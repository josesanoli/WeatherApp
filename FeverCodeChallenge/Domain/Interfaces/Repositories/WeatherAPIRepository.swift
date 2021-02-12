//
//  WeatherRepository.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation

enum WeatherAPIResponse {
    case failure
    case notConnectedToInternet
    case success(weather: WeatherResponse)
}

protocol WeatherAPIRepository {
    func getLocationWeather(latitude: Float, logitude: Float, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}


