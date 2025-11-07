//
//  Homeviewmodel.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

class HomeViewModel{
	private let weatherService: WeatherServiceProtocol
	private let storageService: StorageServiceProtocol
	
	
	var cityName: String = ""
	var weather: Weather?
	
	
	// Callbacks for view updates
	var onLoadingStateChanged: ((Bool) -> Void)?
	var onWeatherFetched: ((Weather) -> Void)?
	var onError: ((String) -> Void)?
	var onFavoriteCityLoaded: ((String) -> Void)?
	
	// MARK: - Initialization (Dependency Injection)
	init(weatherService: WeatherServiceProtocol, storageService: StorageServiceProtocol) {
		self.weatherService = weatherService
		self.storageService = storageService
	}
	
	// MARK: - Business Logic
	
	func viewDidLoad() {
		loadFavoriteCity()
	}
	
	func loadFavoriteCity() {
		if let favoriteCity = storageService.getFavoriteCity() {
			cityName = favoriteCity
			onFavoriteCityLoaded?(favoriteCity)
		}
	}
	
	func searchWeather() {
		let trimmedCity = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
		
		// Validate input
		guard !trimmedCity.isEmpty else {
			onError?("Please enter a city name")
			return
		}
		
		// Update loading state
		onLoadingStateChanged?(true)
		
		// Fetch weather data
		weatherService.fetchWeather(for: trimmedCity) { [weak self] result in
			DispatchQueue.main.async {
				self?.onLoadingStateChanged?(false)
				
				switch result {
				case .success(let weather):
					self?.weather = weather
					self?.onWeatherFetched?(weather)
					
				case .failure(let error):
					self?.onError?(error.localizedDescription)
				}
			}
		}
	}
	
	func saveFavoriteCity() {
		let trimmedCity = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
		guard !trimmedCity.isEmpty else { return }
		
		storageService.saveFavoriteCity(trimmedCity)
	}
	
	func clearFavoriteCity() {
		storageService.clearFavoriteCity()
		cityName = ""
	}
}
