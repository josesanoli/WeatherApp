//
//  ViewController.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import UIKit

final class WeatherViewController: UIViewController, StoryboardInstantiable {

    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var cloudsLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var newLocationButton: Button!
    
    private var viewModel: WeatherViewModel!

    // MARK: - Lifecycle
    
    static func create(with viewModel: WeatherViewModel) -> WeatherViewController {
        let view = WeatherViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        if let vm = viewModel {
            bind(to: vm)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func bind(to viewModel: WeatherViewModel) {
        viewModel.weatherData.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    // MARK: - Private
    
    private func setupViews() {
        newLocationButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        viewModel.getNewLocation()
    }
    
    private func updateItems() {
        cityLabel.text = viewModel.weatherData.value?.name
        latitudeLabel.text = viewModel.weatherData.value?.coord.lat.toString()
        longitudeLabel.text = viewModel.weatherData.value?.coord.lon.toString()
        weatherDescriptionLabel.text = viewModel.weatherData.value?.weather[0].description
        temperatureLabel.text = viewModel.weatherData.value?.main.temp.kelvinToCelsius()
        cloudsLabel.text = viewModel.weatherData.value?.clouds.all.toString()
        humidityLabel.text = viewModel.weatherData.value?.main.humidity.toString()
        
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        cityLabel.text = viewModel.error.value
    }
}

