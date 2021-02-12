//
//  WeatherSceneDIContainer.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 12/2/21.
//

import UIKit

final class WeatherSceneDIContainer {
    
    init() {
        
    }
    
    // MARK: - Weather Scene
    func makeWeatherViewController() -> WeatherViewController {
        return WeatherViewController.create(with: makeWeatherListViewModel())
    }
    
    func makeWeatherListViewModel() -> WeatherViewModel {
        return WeatherViewModelImpl(fetchWeatherUseCase: makeWeatherUseCase())
    }
    
    // MARK: - Use Cases
    func makeWeatherUseCase() -> FetchWeatherUseCase {
        return FetchWeatherUseCaseImpl(repository: makeWeatherAPIRepository())
    }
    
    // MARK: - Repositories
    func makeWeatherAPIRepository() -> WeatherAPIRepository {
        return WeatherAPIRepositoryImpl()
    }
    
    // MARK: - Flow Coordinators
    func makeWeatherFlowCoordinator(navigationController: UINavigationController) -> WeatherFlowCoordinator {
        return WeatherFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension WeatherSceneDIContainer: WeatherFlowCoordinatorDependencies {}
