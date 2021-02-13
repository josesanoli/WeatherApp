//
//  WeatherResponse+Stub.swift
//  FeverCodeChallengeTests
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import Foundation

extension WeatherResponse {
    static func stub(city: String = "City Test",
                lat: Double = 10 ,
                lon: Double = 50,
                description: String = "Description Test",
                temp: Double = 247,
                clouds: Int = 30,
                humidity: Int = 80) -> Self {
        WeatherResponse(coord: Coord.stub(lat: lat, lon: lon), weather: [Weather.stub(description: description)], base: "stations", main: Main.stub(temp: temp, humidity: humidity), visibility: 16093, wind: Wind(speed: 1.5, deg: 350), clouds: Clouds(all: clouds), dt: 1560350645, sys: Sys(type: 1, id: 5122, message: 0.0123, country: "US", sunrise: 1560343627, sunset: 1560396563), timezone: -25200, id: 420006353, name: city, cod: 200, message: "Message test")
        
    }
}

extension Coord {
    static func stub(lat: Double = 10 ,
                     lon: Double = 50) -> Self{
        Coord(lat: lat, lon: lon)
    }
}

extension Weather {
    static func stub(description: String = "Description Test") -> Self{
        Weather(id: 1, main: "Weather main test", description: description, icon: "01")
    }
}

extension Main {
    static func stub(temp: Double = 247,
                     humidity: Int = 80) -> Self {
        Main(temp: temp, feels_like: 250, temp_min: 240, temp_max: 250, pressure: 1023, humidity: humidity)
    }
}
