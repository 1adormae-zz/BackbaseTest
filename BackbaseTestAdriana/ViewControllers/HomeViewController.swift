//
//  HomeViewController.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, MapSelectedCoordinatesProtocol {
  
    var locations : [WeatherLocation]?
    @IBOutlet var locationsCollection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locations = [WeatherLocation]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectedLocation(weatherLocation:WeatherLocation){
        self.locations?.append(weatherLocation)
        self.locationsCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondViewController = segue.destination as? MapViewController {
            secondViewController.mapSelectionDelegate = self
        }

    }

}

extension HomeViewController: UICollectionViewDataSource {


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let weatherLocations = locations else {
            return 0
        }
        return weatherLocations.count
        
    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationsCollectionViewCell",
                                                      for: indexPath) as! LocationsCollectionViewCell
        cell.titleLabel?.text = self.locations?[indexPath.row].name
        // Configure the cell
        return cell
    }
}

extension HomeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: collectionView.bounds.size.width, height: 100.0)
    }

    
}
