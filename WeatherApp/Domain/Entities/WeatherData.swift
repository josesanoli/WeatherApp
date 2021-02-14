//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

// MARK: - WeatherData
struct WeatherData {
    let lon, lat: Double
    let description, icon: String
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let clouds: Int
    let country: String?
    let city: String
    let pressure: Int
}

// MARK: - ErrorData
struct ErrorData {
    let message: String
}
