//
//  Constants.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

struct Constants {
	
	struct Storyboard {
		static let main = "Main"
	}
	
	struct ViewControllerIdentifiers {
		static let home = "HomeViewController"
		static let weatherDetail = "WeatherDetailViewController"
	}
	
	struct Segues {
		static let showWeatherDetail = "showWeatherDetail"
	}
	
	struct Animation {
		static let splashDuration: TimeInterval = 2.0
	}
}
