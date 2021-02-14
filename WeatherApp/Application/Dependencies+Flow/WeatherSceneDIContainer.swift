//
//  WeatherSceneDIContainer.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 12/2/21.
//

import UIKit

final class WeatherSceneDIContainer {
    
    init() { }
    
    // MARK: - Weather Scene
    func makeWeatherViewController() -> WeatherViewController {
        return WeatherViewController.create(with: makeWeatherViewModel())
    }
    
    func makeWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModelImpl(fetchWeatherUseCase: makeWeatherUseCase(), getLocationUseCase: makeLocationUseCase())
    }
    
    // MARK: - Use Cases
    func makeWeatherUseCase() -> FetchWeatherUseCase {
        return FetchWeatherUseCaseImpl(fetchWeatherRepository: makeWeatherAPIRepository())
    }
    
    func makeLocationUseCase() -> GetLocationUseCase {
        return GetLocationUseCaseImpl(randomLocationRepository: makeRandomLocationRepository())
    }
    
    // MARK: - Repositories
    func makeWeatherAPIRepository() -> WeatherAPIRepository {
        return WeatherAPIRepositoryImpl(networkService: makeNetworkService())
    }
    
    func makeRandomLocationRepository() -> RandomLocationRepository {
        return RandomLocationRepositoryImpl()
    }
    
    // MARK: - NetwokServices
    func makeNetworkService() -> NetworkService {
        return NetworkServiceImpl()
    }
    
    // MARK: - Flow Coordinators
    func makeWeatherFlowCoordinator(navigationController: UINavigationController) -> WeatherFlowCoordinator {
        return WeatherFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension WeatherSceneDIContainer: WeatherFlowCoordinatorDependencies {}
