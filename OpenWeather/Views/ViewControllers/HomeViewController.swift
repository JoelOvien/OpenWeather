//
//  HomeViewController.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import UIKit

class HomeViewController: UIViewController {
	
	// MARK: - UI Elements
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var searchButton: UIButton!
	@IBOutlet weak var saveFavoriteButton: UIButton!
	@IBOutlet weak var clearFavoriteButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK: - Properties
	private var viewModel: HomeViewModel!
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupDependencies()
		setupUI()
		bindViewModel()
		viewModel.viewDidLoad()
	}
	
	// MARK: - Setup
	private func setupDependencies() {
		// Dependency injection - creating services
		let weatherService = WeatherAPIService()
		let storageService = UserDefaultsStorageService()
		
		// Inject dependencies into ViewModel
		viewModel = HomeViewModel(
			weatherService: weatherService,
			storageService: storageService
		)
	}
	
	private func setupUI() {
		title = "Weather Search"
		
		cityTextField.placeholder = "Enter city name"
		cityTextField.borderStyle = .roundedRect
		cityTextField.delegate = self
		cityTextField.returnKeyType = .search
		
		searchButton.setTitle("Search Weather", for: .normal)
		searchButton.backgroundColor = .systemBlue
		searchButton.setTitleColor(.white, for: .normal)
		searchButton.layer.cornerRadius = 8
		
		saveFavoriteButton.setTitle("Save as Favorite", for: .normal)
		saveFavoriteButton.backgroundColor = .systemGreen
		saveFavoriteButton.setTitleColor(.white, for: .normal)
		saveFavoriteButton.layer.cornerRadius = 8
		
		clearFavoriteButton.setTitle("Clear Favorite", for: .normal)
		clearFavoriteButton.backgroundColor = .systemRed
		clearFavoriteButton.setTitleColor(.white, for: .normal)
		clearFavoriteButton.layer.cornerRadius = 8
		
		activityIndicator.hidesWhenStopped = true
	}
	
	private func bindViewModel() {
		// Loading state callback
		viewModel.onLoadingStateChanged = { [weak self] isLoading in
			if isLoading {
				self?.activityIndicator.startAnimating()
				self?.searchButton.isEnabled = false
			} else {
				self?.activityIndicator.stopAnimating()
				self?.searchButton.isEnabled = true
			}
		}
		
		// Weather fetched successfully callback
		viewModel.onWeatherFetched = { [weak self] weather in
			self?.navigateToWeatherDetail(with: weather)
		}
		
		// Error callback
		viewModel.onError = { [weak self] errorMessage in
			self?.showAlert(title: "Error", message: errorMessage)
		}
		
		// Favorite city loaded callback
		viewModel.onFavoriteCityLoaded = { [weak self] city in
			self?.cityTextField.text = city
		}
	}
	
	// MARK: - Actions
	@IBAction func searchButtonTapped(_ sender: UIButton) {
		viewModel.cityName = cityTextField.text ?? ""
		viewModel.searchWeather()
	}
	
	@IBAction func saveFavoriteButtonTapped(_ sender: UIButton) {
		viewModel.cityName = cityTextField.text ?? ""
		viewModel.saveFavoriteCity()
		showAlert(title: "Success", message: "City saved as favorite!")
	}
	
	@IBAction func clearFavoriteButtonTapped(_ sender: UIButton) {
		viewModel.clearFavoriteCity()
		cityTextField.text = ""
		showAlert(title: "Success", message: "Favorite city cleared!")
	}
	
	// MARK: - Navigation
	private func navigateToWeatherDetail(with weather: Weather) {
		let storyboard = UIStoryboard(name: Constants.Storyboard.main, bundle: nil)
		guard let detailVC = storyboard.instantiateViewController(
			withIdentifier: Constants.ViewControllerIdentifiers.weatherDetail
		) as? WeatherDetailViewController else {
			return
		}
		
		detailVC.weather = weather
		navigationController?.pushViewController(detailVC, animated: true)
	}
	
	// MARK: - Helper Methods
	private func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		viewModel.cityName = textField.text ?? ""
		viewModel.searchWeather()
		return true
	}
}
