//
//  WeatherViewModelTest.swift
//  FeverCodeChallengeTests
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import XCTest

class WeatherViewModelTests: XCTestCase {
 
    class GetLocationUseCaseMock: GetLocationUseCase {
        
        var coord = LocationCoordinates(latitude: 10, longitude: -50)
        
        func getRandomLocation(completion: @escaping (LocationCoordinates) -> Void) {
            completion(coord)
        }
    }
    
    class FetchWeatherUseCaseMock: FetchWeatherUseCase {
        
        var expectation: XCTestExpectation?
        var error: NetworkError?
        var weatherData = WeatherData(lon: -23, lat: 43, description: "Test description", icon: "01", temp: 278, humidity: 60, windSpeed: 3.4, clouds: 20, country: "US", city: "City Test", pressure: 1024)
        
        func getLocationWeather(requestValue: LocationCoordinates, completion: @escaping (Result<WeatherData, NetworkError>) -> Void) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(weatherData))
            }
            DispatchQueue.main.async {
                self.expectation?.fulfill()
            }
        }
    }
    
    func test_whenGetLocationRandomData_thenViewModelGetSuccessfullyWeatherData() {
        // given
        let getLocationUseCaseMock = GetLocationUseCaseMock()
        let fetchWeatherUseCaseMock = FetchWeatherUseCaseMock()
        fetchWeatherUseCaseMock.expectation = self.expectation(description: "Get data")
        
        let viewModel = WeatherViewModelImpl(fetchWeatherUseCase: fetchWeatherUseCaseMock, getLocationUseCase: getLocationUseCaseMock)
        
        // when
        viewModel.getNewLocation()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.weatherData.value?.lat, 43)
        //XCTAssertTrue(viewModel.)
    }
    
    func test_whenGetLocationRandomData_thenViewModelGetErrorWeatherData() {
        // given
        let getLocationUseCaseMock = GetLocationUseCaseMock()
        let fetchWeatherUseCaseMock = FetchWeatherUseCaseMock()
        fetchWeatherUseCaseMock.error = NetworkError.notConnected
        fetchWeatherUseCaseMock.expectation = self.expectation(description: "Get data")
        
        let viewModel = WeatherViewModelImpl(fetchWeatherUseCase: fetchWeatherUseCaseMock, getLocationUseCase: getLocationUseCaseMock)
        
        // when
        viewModel.getNewLocation()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.error.value, localizedString("generic_error"))
    }
    
}
