//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import Foundation


protocol WeatherViewModelInput {
    func getNewLocation()
}

protocol WeatherViewModelOutput {
    var weatherData: Observable<WeatherData?> { get }
    var error: Observable<String> { get }
}

protocol WeatherViewModel: WeatherViewModelInput, WeatherViewModelOutput { }

final class WeatherViewModelImpl: WeatherViewModel {
    
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private let getLocationUseCase: GetLocationUseCase
    
    // MARK: - OUTPUT

    let weatherData: Observable<WeatherData?> = Observable(.none)
    let error: Observable<String> = Observable("")
    
    // MARK: - Init

    init(fetchWeatherUseCase: FetchWeatherUseCase, getLocationUseCase: GetLocationUseCase) {
        
        self.fetchWeatherUseCase = fetchWeatherUseCase
        self.getLocationUseCase = getLocationUseCase
        
    }
    
    
    // MARK: - Private

    private func getLocation() {
        
        getLocationUseCase.getRandomLocation(completion: { result in
            self.getWeather(location: result)
        })

    }
    
    private func getWeather(location: LocationCoordinates) {
        
        fetchWeatherUseCase.getLocationWeather(requestValue: location, completion: { [weak self] result in
            DispatchQueue.main.async {
                //Update result
                switch result {
                case .success(let weatherData):
                    self?.weatherData.value = weatherData
                case .failure:
                    self?.error.value = localizedString("generic_error")
                }
            }
        })
    }
    
}

// MARK: - INPUT. View event methods

extension WeatherViewModelImpl {
    
    //New location button pressed
    func getNewLocation() {
        getLocation()
    }
}
