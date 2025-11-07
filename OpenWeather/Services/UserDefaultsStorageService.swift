//
//  UserDefaultsStorageService.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

class UserDefaultsStorageService: StorageServiceProtocol {
	
	private let userDefaults: UserDefaults
	private let favoriteCityKey = "favoriteCityKey"
	
	init(userDefaults: UserDefaults = .standard) {
		self.userDefaults = userDefaults
	}
	
	func saveFavoriteCity(_ city: String) {
		userDefaults.set(city, forKey: favoriteCityKey)
		userDefaults.synchronize()
	}
	
	func getFavoriteCity() -> String? {
		return userDefaults.string(forKey: favoriteCityKey)
	}
	
	func clearFavoriteCity() {
		userDefaults.removeObject(forKey: favoriteCityKey)
		userDefaults.synchronize()
	}
}
