//
//  AppDIContainer.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 12/2/21.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - DIContainers of scenes
    func makeWeatherSceneDIContainer() -> WeatherSceneDIContainer {
        
        return WeatherSceneDIContainer()
    }
}
