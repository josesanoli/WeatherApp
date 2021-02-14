//
//  WeatherAPIRepositoryTest.swift
//  WeatherAppTests
//
//  Created by Jose Luis Sánchez on 13/2/21.
//

import XCTest

class WeatherAPIRepositoryTest: XCTestCase {
    
    private class NetworkServiceMock: NetworkService {
        
        var error: NetworkError?
        var json: String = jsonTest
        
        func request(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
            
            if let error = error {
                completion(.failure(error))
            } else {
                if let data = jsonToData(json: json){
                    completion(.success(data))
                } else {
                    completion(.failure(.decodeError))
                }
                
            }
        }
        
    }
    
    func testWeatherRepository_whenSuccessfullyGetNetworkService_thenReturnData() {
        // given
        let expectation = self.expectation(description: "Network error received")
        expectation.expectedFulfillmentCount = 1
        let networkService = NetworkServiceMock()
        let repository = WeatherAPIRepositoryImpl(networkService: networkService)
        
        // when
        let latitude: Double = 20
        let longitude: Double = -30
        var result: WeatherResponse?
        repository.getAPILocationWeather(latitude: latitude, longitude: longitude, completion: { response in
            result = try? response.get()
            expectation.fulfill()
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result?.name, "Test City")
        XCTAssertEqual(result?.coord.lat, latitude)

    }
    
    func testWeatherRepository_whenFailedGetNetworkService_thenReturnError() {
        // given
        let expectation = self.expectation(description: "Network error received")
        expectation.expectedFulfillmentCount = 1
        let networkService = NetworkServiceMock()
        networkService.error = NetworkError.notConnected
        let repository = WeatherAPIRepositoryImpl(networkService: networkService)
        
        // when
        let latitude: Double = 20
        let longitude: Double = -30
        var error: NetworkError?
        repository.getAPILocationWeather(latitude: latitude, longitude: longitude, completion: { response in
            if case .failure(let responseError) = response {
                error = responseError
            }
            expectation.fulfill()
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(error?.localizedDescription, NetworkError.notConnected.localizedDescription)

    }
    
    func testWeatherRepository_whenBadRequestGetNetworkService_thenReturnError() {
        // given
        let expectation = self.expectation(description: "API error received")
        expectation.expectedFulfillmentCount = 1
        let networkService = NetworkServiceMock()
        networkService.json = jsonErrorTest
        let repository = WeatherAPIRepositoryImpl(networkService: networkService)
        
        // when
        let latitude: Double = 20
        let longitude: Double = -30
        var error: NetworkError?
        repository.getAPILocationWeather(latitude: latitude, longitude: longitude, completion: { response in
            if case .failure(let responseError) = response {
                error = responseError
            }
            expectation.fulfill()
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(error, NetworkError.error(statusCode: 401, message: "Message to test"))
        
    }
    
    func testWeatherRepository_whenBadJsonGetNetworkService_thenReturnError() {
        // given
        let expectation = self.expectation(description: "API error received")
        expectation.expectedFulfillmentCount = 1
        let networkService = NetworkServiceMock()
        networkService.json = jsonBadFormedTest
        let repository = WeatherAPIRepositoryImpl(networkService: networkService)
        
        // when
        let latitude: Double = 20
        let longitude: Double = -30
        var error: NetworkError?
        repository.getAPILocationWeather(latitude: latitude, longitude: longitude, completion: { response in
            if case .failure(let responseError) = response {
                error = responseError
            }
            expectation.fulfill()
        })
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(error, NetworkError.error(statusCode: 401, message: "Message to test"))
        
    }
    
}

