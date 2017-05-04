//
//  MapViewController.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    @IBOutlet var map: MKMapView!
    
    var manager = CLLocationManager()
    var currentCoordinate : CLLocationCoordinate2D?
    var currentLoactionName : String?
    var currentAnnotation : MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let longPressGestureRecog = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.longpress(gestureRecognizer:)))
        
        longPressGestureRecog.minimumPressDuration = 1
        
        map.addGestureRecognizer(longPressGestureRecog)
        
    }
    
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            
            self.currentCoordinate = newCoordinate
            
            self.manageNewLocationSelected(newCoordinate: newCoordinate)
        }
        
    }
    
    
    func manageNewLocationSelected(newCoordinate: CLLocationCoordinate2D ){
        let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        
        var title = ""
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            
            if error != nil {
                
                print("ERROR: Could not fin the location information")
                
            } else {
                //Seach for the street name and the city extra info if is available
                if let placemark = placemarks?[0] {
                    
                    if let city = placemark.locality  {
                        
                        title += " \(city) "
                        
                    }
                    
                    if let country = placemark.country {
                        
                        title += "(\(country)) "
                    }
                }
                
            }
            
            if title == "" {
                
                title = "Added (\(newCoordinate.latitude), \(newCoordinate.longitude))"
                
            }
            
            self.currentLoactionName = title
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = newCoordinate
            
            annotation.title = title
            self.replaceAnnotation(annotation: annotation)
            
        })

    }
    
    
    func replaceAnnotation(annotation : MKAnnotation){
        if let oldAnnotation = self.currentAnnotation{
            self.map.removeAnnotation(oldAnnotation)
        }
        self.currentAnnotation = annotation
        self.map.addAnnotation(annotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.map.setRegion(region, animated: true)
        
    }
  
    @IBAction func didSelecedAdd() {
        if let selectedCoordinares = self.currentCoordinate{
            let weatherLocation  = WeatherLocation(coordinates: selectedCoordinares)
            weatherLocation.name = currentLoactionName
            DataManager.sharedInstance.addLocation(weatherLocation: weatherLocation)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
