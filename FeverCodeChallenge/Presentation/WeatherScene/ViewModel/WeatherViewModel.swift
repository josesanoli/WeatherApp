//
//  WeatherViewModel.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation


protocol WeatherViewModelInput {
    func getNewLocation()
}

protocol WeatherViewModelOutput {
    var weatherData: Observable<WeatherResponse?> { get }
    var error: Observable<String> { get }
}

protocol WeatherViewModel: WeatherViewModelInput, WeatherViewModelOutput { }

final class WeatherViewModelImpl: WeatherViewModel {
    
    private let fetchWeatherUseCase: FetchWeatherUseCase
    
    // MARK: - OUTPUT

    let weatherData: Observable<WeatherResponse?> = Observable(.none)
    let error: Observable<String> = Observable("")
    
    // MARK: - Init

    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    
    // MARK: - Private

    private func getLocation() {
        //New location
        let coordinates = LocationCoordinates(latitude: 40.4165, longitude: -3.70256)
        //Fetch weather
        fetchWeatherUseCase.getLocationWeather(requestValue: coordinates, completion: { [weak self] result in
            DispatchQueue.main.async {
                //Update result
                switch result {
                case .success(let weatherData):
                    self?.weatherData.value = weatherData
                case .failure(let error):
                    self?.error.value = error.localizedDescription
                }
            }
        })

    }
    
    
}

// MARK: - INPUT. View event methods

extension WeatherViewModelImpl {
    
    func getNewLocation() {
        //New location pressed
        getLocation()
    }
}
