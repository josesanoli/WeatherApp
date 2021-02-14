//
//  FetchWeatherUseCase.swift
//  WeatherAppTests
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import XCTest

class FetchWeatherUseCaseTest: XCTestCase {
    
    private class WeatherAPIRepositoryMock: WeatherAPIRepository {
        
        var error: NetworkError?
        
        func getAPILocationWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void){
            let weatherFetch: WeatherResponse = WeatherResponse.stub(city: "City UCTest", lat: latitude, lon: longitude, description: "Description UCTest", temp: 280, clouds: 20, humidity: 70)
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(weatherFetch))
            }
        }
    }
    
    
    func testFetchWeatherUseCase_whenSuccessfullyFetchingWeather_thenReturnData() {
        // given
        let expectation = self.expectation(description: "Data received")
        expectation.expectedFulfillmentCount = 1
        let weatherAPIRepository = WeatherAPIRepositoryMock()
        let useCase = FetchWeatherUseCaseImpl(fetchWeatherRepository: weatherAPIRepository)
        
        // when
        let requestValue = LocationCoordinates(latitude: 20, longitude: -30)
        var result: WeatherData?
        useCase.getLocationWeather(requestValue: requestValue, completion: { response in
            result = try? response.get()
            expectation.fulfill()
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result?.city, "City UCTest")
        XCTAssertEqual(result?.lat, requestValue.latitude)

    }
    
    func testFetchWeatherUseCase_whenFailedFetchingWeather_thenReturnError() {
        // given
        let expectation = self.expectation(description: "Error received")
        expectation.expectedFulfillmentCount = 1
        let weatherAPIRepository = WeatherAPIRepositoryMock()
        weatherAPIRepository.error = NetworkError.notConnected
        let useCase = FetchWeatherUseCaseImpl(fetchWeatherRepository: weatherAPIRepository)
        
        
        // when
        let requestValue = LocationCoordinates(latitude: 20, longitude: -30)
        var error: NetworkError?
        useCase.getLocationWeather(requestValue: requestValue, completion: { response in
            if case .failure(let responseError) = response {
                error = responseError
            }
            expectation.fulfill()
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(error?.localizedDescription, NetworkError.notConnected.localizedDescription)

    }
}
