//
//  FavourieTableViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 01/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit
import CoreData

class FavouriteTableViewController: TableSearchViewController {
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cities = dataController.fetchEntity("CoreCity") as? [CoreCity] {
            self.cities = cities
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FavouriteTableViewController {
    
    // MARK: Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ( searchIsActive ? filterCities.count : cities.count )
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CityTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
        
        if searchIsActive {
            return cellUsingCity(cell: cell, city: filterCities[indexPath.row])
        }
        else {
            return cellUsingCity(cell: cell, city: cities[indexPath.row])
        }
    }
    
    func cellUsingCity(cell: CityTableViewCell, city: CityProtocol) -> CityTableViewCell {
        
        cell.cityId = city.id
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        cell.directionImage.image = city.windDirectionImage
        
        return cell
        
    }
}
