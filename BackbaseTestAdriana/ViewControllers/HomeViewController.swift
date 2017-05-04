//
//  HomeViewController.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, MapSelectedCoordinatesProtocol{
  
    var locations : [WeatherLocation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locations = [WeatherLocation]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectedCoordinates(coordinates: CLLocationCoordinate2D) {
        let newEeatherLocation = WeatherLocation(coordinates: coordinates)
        self.locations?.append(newEeatherLocation)
    }

}

