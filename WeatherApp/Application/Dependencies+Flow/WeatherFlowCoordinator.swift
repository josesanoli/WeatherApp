//
//  WeatherFlowCoordinator.swift
//  WeatherApp
//
//  Created by Jose Luis Sánchez on 12/2/21.
//

import UIKit

protocol WeatherFlowCoordinatorDependencies  {
    func makeWeatherViewController() -> WeatherViewController
}

final class WeatherFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: WeatherFlowCoordinatorDependencies

    private weak var weatherVC: WeatherViewController?

    init(navigationController: UINavigationController, dependencies: WeatherFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeWeatherViewController()
        navigationController?.pushViewController(vc, animated: false)
        weatherVC = vc
    }
}
