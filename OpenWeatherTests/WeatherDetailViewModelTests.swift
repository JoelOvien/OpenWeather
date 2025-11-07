//
//  WeatherDetailViewModelTests.swift
//  WeatherAppTests
//
//  Unit tests for WeatherDetailViewModel
//

import XCTest
@testable import WeatherApp

class WeatherDetailViewModelTests: XCTestCase {
    
    var sut: WeatherDetailViewModel!
    var mockWeather: Weather!
    
    override func setUp() {
        super.setUp()
        mockWeather = Weather(
            cityName: "London",
            temperature: 15.5,
            description: "Cloudy",
            humidity: 75,
            windSpeed: 8.3
        )
        sut = WeatherDetailViewModel(weather: mockWeather)
    }
    
    override func tearDown() {
        sut = nil
        mockWeather = nil
        super.tearDown()
    }
    
    // MARK: - Tests for computed properties
    
    func testCityName_ReturnsCorrectValue() {
        XCTAssertEqual(sut.cityName, "London")
    }
    
    func testTemperature_ReturnsFormattedString() {
        XCTAssertEqual(sut.temperature, "15.5°C")
    }
    
    func testDescription_ReturnsCorrectValue() {
        XCTAssertEqual(sut.description, "Cloudy")
    }
    
    func testHumidity_ReturnsFormattedString() {
        XCTAssertEqual(sut.humidity, "75%")
    }
    
    func testWindSpeed_ReturnsFormattedString() {
        XCTAssertEqual(sut.windSpeed, "8.3 m/s")
    }
    
    func testDisplayTitle_ReturnsCorrectFormat() {
        XCTAssertEqual(sut.displayTitle, "Weather in London")
    }
    
    // MARK: - Tests with different weather data
    
    func testViewModel_WithDifferentTemperature() {
        // Given
        let weather = Weather(
            cityName: "Tokyo",
            temperature: 28.7,
            description: "Sunny",
            humidity: 50,
            windSpeed: 3.2
        )
        let viewModel = WeatherDetailViewModel(weather: weather)
        
        // Then
        XCTAssertEqual(viewModel.temperature, "28.7°C")
    }
    
    func testViewModel_WithNegativeTemperature() {
        // Given
        let weather = Weather(
            cityName: "Moscow",
            temperature: -5.3,
            description: "Snowy",
            humidity: 85,
            windSpeed: 12.0
        )
        let viewModel = WeatherDetailViewModel(weather: weather)
        
        // Then
        XCTAssertEqual(viewModel.temperature, "-5.3°C")
    }
    
    func testViewModel_WithZeroWindSpeed() {
        // Given
        let weather = Weather(
            cityName: "Calm City",
            temperature: 20.0,
            description: "Clear",
            humidity: 60,
            windSpeed: 0.0
        )
        let viewModel = WeatherDetailViewModel(weather: weather)
        
        // Then
        XCTAssertEqual(viewModel.windSpeed, "0.0 m/s")
    }
}
