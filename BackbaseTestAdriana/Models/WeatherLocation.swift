//
//  WeatherLocation.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation
import CoreLocation


class WeatherLocation {
    
    private (set) var name : String?
    private (set) var coordinates : CLLocationCoordinate2D
    private (set) var mainInfo : String?
    private (set) var descriptionInfo : String?
    private (set) var temperature : String?
    private (set) var humidity: String?
    private (set) var rainChance:String?
    private (set) var windSpeed: String?
    private (set) var windDirection: String?
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
}
