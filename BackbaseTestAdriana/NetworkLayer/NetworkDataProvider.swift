//
//  NetworkDataProvider.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation
import CoreLocation

protocol DataProviderProtocol{
    func getWeatherFor(locationWeather:WeatherLocation, completionHandler: @escaping CallBack)
}

typealias CallBack = ((Any?) -> Void)

class NetworkDataProvider: DataProviderProtocol{
    let todoEndpoint: String = "http://api.openweathermap.org/data/2.5/weather?lat=43.444&lon=45.55&appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
    
    func getWeatherFor(locationWeather:WeatherLocation, completionHandler: @escaping CallBack)  {
    
        guard let url = self.createURL(weatherLocation: locationWeather) else {
            print("ERROR: Can't create the URL!")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        print(url.absoluteString)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error{
                print(error)
            }
            guard let responseData = data  else{
                completionHandler(nil)
                print("ERROR: Empty response from api.openweathermap.org")
                return
            }
            do {
                let json =   try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                guard let collectionDictionary = json as? [String: Any] else{
                    completionHandler(nil)
                    return
                }
                DispatchQueue.main.async {
                    completionHandler( weatherLocationMapper(json: collectionDictionary))
                }
                
            } catch{
                completionHandler(nil)
            }
        })
        task.resume()
    }
    
    func getWeatherFor(coordinates:CLLocationCoordinate2D, completionHandler: @escaping CallBack){
        
    }
    
    
    
    
    private func createURL(weatherLocation:WeatherLocation) -> URL?{
        if let name = weatherLocation.name,
            let url = self.createURLFor(name: name){
            return url
        }
        else if let url2 = self.createURLFor(coordinates: weatherLocation.coordinates){
            return url2
        }
        return nil
    }
    
    private func createURLFor(name:String) -> URL?{
        let todoEndpoint: String = "http://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL from Location Name")
            return nil
        }
        return url
    }
    
    private func createURLFor(coordinates:CLLocationCoordinate2D) -> URL?{
        let todoEndpoint: String = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL from Coordinates")
            return nil
        }
        return url
    }

}
