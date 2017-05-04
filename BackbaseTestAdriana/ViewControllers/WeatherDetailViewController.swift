//
//  WeatherDetailViewController.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation
import UIKit


class WeatherDetailViewController : UIViewController{
    
    var weatherLocation:WeatherLocation?
    @IBOutlet var nameLabel : UILabel?
    @IBOutlet var tempLabel : UILabel?
    @IBOutlet var humidityLabel : UILabel?
    @IBOutlet var rainLabel : UILabel?
    @IBOutlet var windLabel : UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.weatherLocation?.name ?? ""

        if let weatherLocation = weatherLocation{
            DataManager.sharedInstance.weatherLocationFor(weatherLocation: weatherLocation) { (result) in
                if let weatherResult = result as? WeatherLocation{
                    self.fillInWith(weatherLocation: weatherResult)
                }
            }
        }
    }
    
    func fillInWith(weatherLocation:WeatherLocation){
        
        let temperature = "\(String(describing: weatherLocation.temperature ?? ""))\u{00B0}"
        self.tempLabel?.text = temperature
        self.humidityLabel?.text = weatherLocation.humidity ?? ""
        self.rainLabel?.text = "\(String(describing: weatherLocation.rainChance ?? ""))%"
        self.windLabel?.text = "\(String(describing: weatherLocation.windSpeed ?? "")) meter/sec"
        
    }
    
}
