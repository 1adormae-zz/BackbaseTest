//
//  NetworkDataProvider.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation

protocol DataProviderProtocol{
    func getCollection(completionHandler:@escaping CallBack)
}

typealias CallBack = ((Any?) -> Void)

class NetworkDataProvider: DataProviderProtocol{
    let todoEndpoint: String = "https://www.rijksmuseum.nl/api/nl/collection?q=rembrant&key=uQIiUF3Q&format=json"
    
    func getCollection(completionHandler: @escaping CallBack)  {
        
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            completionHandler(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let responseData = data  else{
                completionHandler(nil)
                print("ERROR: Empty response from www.rijksmuseum.nl")
                return
            }
            do {
                let json =   try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                guard let collectionDictionary = json["artObjects"] as? [[String: Any]] else{
                    completionHandler(nil)
                    return
                }
                DispatchQueue.main.async {
//                    completionHandler( artCollectionMapper(collectionJson: collectionDictionary))
                }
                
            } catch{
                completionHandler(nil)
            }
        })
        task.resume()
    }
}
