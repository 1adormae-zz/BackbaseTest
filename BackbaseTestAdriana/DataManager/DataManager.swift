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
    
    func addLocation(weatherLocation: WeatherLocation){
        
        if let name = weatherLocation.name{
            self.weatherLocations[name] = weatherLocation
        }
        else{
            print("ERROR: The new location could not be saved")
        }
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
    
    func saveLocations(){
        let locationsData = NSKeyedArchiver.archivedData(withRootObject: weatherLocations)
        UserDefaults.standard.set(locationsData, forKey: "locations")
    }
    
    func loadLocations(){
        let locationsData = UserDefaults.standard.object(forKey: "locations") as? Data
        
        if let locationsData = locationsData {
//            self.weatherLocations = NSKeyedUnarchiver.unarchiveObject(with: locationsData) as? [String:WeatherLocation]
        }
    }
    
}
