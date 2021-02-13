//
//  ViewController.swift
//  FeverCodeChallenge
//
//  Created by Jose Luis Sánchez on 11/2/21.
//

import UIKit

final class WeatherViewController: UIViewController, StoryboardInstantiable {

    
    @IBOutlet private weak var cityLabel: UILabel!
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
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        cityLabel.text = viewModel.error.value
    }
}

