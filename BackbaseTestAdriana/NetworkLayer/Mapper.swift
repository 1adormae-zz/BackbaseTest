//
//  Mapper.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation
import CoreLocation

func weatherLocationMapper (json: [String:Any] ) -> WeatherLocation? {
    
    let weatherLoc : WeatherLocation = WeatherLocation(coordinates: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
    //Map the Coordinates
    if let coord = json["coord"] as? [String:Any],
        let lon = coord["lon"] as? Double,
        let lat = coord["lat"] as? Double {
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        weatherLoc.coordinates = coordinates
    }
    
    //Map Wind
    if let wind = json["wind"] as? [String:Any],
        let speed = wind["speed"] as? String,
        let deg = wind["deg"] as? String{
        weatherLoc.windSpeed = speed
        weatherLoc.windDirection = deg
    }
    
    //Map main info
    if let main = json["main"] as? [String:Any],
        let temp = main["temp"] as? String,
        let humidity = main["humidity"] as? String{
        weatherLoc.humidity = humidity
        weatherLoc.temperature = temp
    }
    
    //Map the % rain with clouds
    if let clouds = json["coulds"] as? [String:Any],
        let chance = clouds["clouds.all"] as? String{
        weatherLoc.rainChance = chance
    }

    
    return weatherLoc
}

