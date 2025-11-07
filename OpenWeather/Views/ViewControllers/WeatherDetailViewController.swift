//
//  WeatherDetailViewController.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//

import UIKit

class WeatherDetailViewController: UIViewController {
	
	// MARK: - UI Elements
	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var humidityLabel: UILabel!
	@IBOutlet weak var windSpeedLabel: UILabel!
	
	// MARK: - Properties
	var weather: Weather?
	private var viewModel: WeatherDetailViewModel!
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViewModel()
		setupUI()
		displayWeatherData()
	}
	
	// MARK: - Setup
	private func setupViewModel() {
		guard let weather = weather else { return }
		viewModel = WeatherDetailViewModel(weather: weather)
	}
	
	private func setupUI() {
		view.backgroundColor = .systemBackground
		
		cityNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
		cityNameLabel.textAlignment = .center
		
		temperatureLabel.font = UIFont.systemFont(ofSize: 48, weight: .light)
		temperatureLabel.textAlignment = .center
		
		descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		descriptionLabel.textAlignment = .center
		descriptionLabel.numberOfLines = 0
		
		humidityLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		humidityLabel.textAlignment = .center
		
		windSpeedLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		windSpeedLabel.textAlignment = .center
	}
	
	private func displayWeatherData() {
		guard let viewModel = viewModel else { return }
		
		title = viewModel.displayTitle
		cityNameLabel.text = viewModel.cityName
		temperatureLabel.text = viewModel.temperature
		descriptionLabel.text = viewModel.description
		humidityLabel.text = "Humidity: \(viewModel.humidity)"
		windSpeedLabel.text = "Wind Speed: \(viewModel.windSpeed)"
	}
}
