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
    
    var name : String?
    var coordinates : CLLocationCoordinate2D
    var mainInfo : String?
    var descriptionInfo : String?
    var temperature : String?
    var humidity: String?
    var rainChance:String?
    var windSpeed: String?
    var windDirection: String?
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
}
