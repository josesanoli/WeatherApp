//
//  WeatherRepository.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

enum WeatherAPIResponse {
    case failure
    case notConnectedToInternet
    case success(weather: WeatherResponse)
}

protocol WeatherAPIRepository {
    func getAPILocationWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
}


