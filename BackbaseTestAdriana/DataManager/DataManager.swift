//
//  DataManager.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation

class DataManager{
    
    static let sharedInstance : DataManager = {
        let instance = DataManager(weatherLocations: [:])
        return instance
    }()
    
    var weatherLocations : [String:WeatherLocation]
    private var dataProvider: DataProviderProtocol
    
    init( weatherLocations: [String:WeatherLocation]) {
        self.weatherLocations = weatherLocations
        self.dataProvider = NetworkDataProvider()
    }
    
    func setDataProvider (otherDataProvider: DataProviderProtocol){
        self.dataProvider = otherDataProvider
    }
    
    func weatherLocationFor(weatherLocation:WeatherLocation, completionHandler:@escaping CallBack){
        self.dataProvider.getWeatherFor(locationWeather: weatherLocation) { result in
            print(result ?? "EEROOORRRRR")
            completionHandler(result)
        }
    }
    
}
