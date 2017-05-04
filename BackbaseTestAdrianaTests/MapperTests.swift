//
//  MapperTests.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation

import XCTest
import CoreLocation
@testable import BackbaseTestAdriana

class MapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testArtCollectionMapper() {
        let mockDictionary = generateJson(fromFile: "response")
        if let dict = mockDictionary as? [String:Any],
            let weatherLocation = weatherLocationMapper(json: dict){
            XCTAssertNotNil(weatherLocation)
            XCTAssert(weatherLocation.name == "Ruhrort")
        }
    }
    
    
    
    
    public func generateJson(fromFile: String) -> Any? {
        do {
            
            if let file = Bundle.main.url(forResource: fromFile, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                    return json
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    return json
                } else {
                    print("JSON is invalid")
                    return nil
                }
            } else {
                print("no file")
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    
}

