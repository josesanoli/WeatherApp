//
//  ViewController.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import UIKit

final class WeatherViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var cloudsLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
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
        viewModel.error.observe(on: self) { [weak self] in self?.emptyState($0) }
    }
    
    // MARK: - Private
    
    private func setupViews() {
        newLocationButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        viewModel.getNewLocation()
    }
    
    private func updateItems() {
        if let values = viewModel.weatherData.value {
            titleLabel.text = localizedString("title_text")
            if !values.city.isEmpty {
                cityLabel.text = values.city
                latitudeLabel.text = ""
                longitudeLabel.text = ""
            } else {
                cityLabel.text = ""
                latitudeLabel.text = localizedString("latitude") + ": " + values.lat.toString()
                longitudeLabel.text = localizedString("longitude") + ": " + values.lon.toString()
            }
        
            temperatureLabel.text =  values.temp.kelvinToCelsius() + "ºC"
            weatherDescriptionLabel.text = values.description.capitalizingFirstLetter()
            cloudsLabel.text = values.clouds.toString() + "%"
            windSpeedLabel.text = values.windSpeed.toString2Dec() + " m/s"
            humidityLabel.text = values.humidity.toString() + "%"
            pressureLabel.text = values.pressure.toString() + " hPa"
        } else {
            emptyState(localizedString("tap_button"))
        }
    }
    
    private func emptyState(_ message: String) {
        titleLabel.text = message.isEmpty ? localizedString("tap_button") : message
        cityLabel.text = "-"
        latitudeLabel.text = ""
        longitudeLabel.text = ""
        weatherDescriptionLabel.text = "-"
        temperatureLabel.text = "-"
        cloudsLabel.text = "-"
        windSpeedLabel.text = "-"
        humidityLabel.text = "-"
        pressureLabel.text = "-"
    }
}

