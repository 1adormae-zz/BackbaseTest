//
//  HomeViewController.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var selectedKey : String?
    @IBOutlet var locationsCollection : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.locationsCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondViewController = segue.destination as? WeatherDetailViewController {
            if let key = self.selectedKey{
                secondViewController.weatherLocation = DataManager.sharedInstance.weatherLocations[key]
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return DataManager.sharedInstance.weatherLocations.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationsCollectionViewCell",
                                                      for: indexPath) as! LocationsCollectionViewCell
        let keys =  Array(DataManager.sharedInstance.weatherLocations.keys)
        let key = keys[indexPath.row]
        cell.titleLabel?.text = DataManager.sharedInstance.weatherLocations[key]?.name
        // Configure the cell
        return cell
    }
}

extension HomeViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let keys =  Array(DataManager.sharedInstance.weatherLocations.keys)
        self.selectedKey = keys[indexPath.row]
        self.performSegue(withIdentifier: "showWeatherDetail", sender: self)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.bounds.size.width, height: 100.0)
    }
    
    
}
