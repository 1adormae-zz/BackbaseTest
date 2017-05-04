//
//  BackbaseTestAdrianaTests.swift
//  BackbaseTestAdrianaTests
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import XCTest
import CoreLocation
@testable import BackbaseTestAdriana

class DataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        DataManager.sharedInstance.setDataProvider(otherDataProvider: DataProviderMock())
        
    }
    
    
    func testAddLocation() {
        
        let coor = CLLocationCoordinate2D(latitude: 44.5, longitude: 22.5)
        let locationWeather = WeatherLocation(coordinates: coor)
        locationWeather.name = "Vitoria-Gasteiz"
        locationWeather.humidity = "70"
        locationWeather.rainChance = "10"
        locationWeather.temperature = "20"
        
        DataManager.sharedInstance.addLocation(weatherLocation: locationWeather)
        
        let weatherLocation = DataManager.sharedInstance.weatherLocations["Vitoria-Gasteiz"]
        XCTAssert((weatherLocation != nil))
        
        
    }
    
    func testWeatherLocationFor(){
        
        let coor = CLLocationCoordinate2D(latitude: 44.5, longitude: 22.5)
        let locationWeather = WeatherLocation(coordinates: coor)
        locationWeather.name = "Madrid"
        locationWeather.humidity = "40"
        locationWeather.rainChance = "40"
        locationWeather.temperature = "30"
        
        DataManager.sharedInstance.weatherLocationFor(weatherLocation: locationWeather) { (result) in
            if let weatherResult = result as? WeatherLocation{
                XCTAssert(weatherResult.name == "Vitoria-Gasteiz")
            }
            
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class DataProviderMock: DataProviderProtocol{
    
    func getWeatherFor(locationWeather:WeatherLocation, completionHandler: @escaping CallBack) {
        
        let coordinates = CLLocationCoordinate2D(latitude: locationWeather.coordinates.latitude, longitude: locationWeather.coordinates.longitude)
        let locationWeatherFilledIn = WeatherLocation(coordinates: coordinates)
        locationWeatherFilledIn.name = "Vitoria-Gasteiz"
        locationWeatherFilledIn.humidity = "70"
        locationWeatherFilledIn.rainChance = "10"
        locationWeatherFilledIn.temperature = "20"
        
        completionHandler(locationWeatherFilledIn)
    }
    
}
