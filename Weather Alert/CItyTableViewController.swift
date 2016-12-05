//
//  CItyTableViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 22/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit
import CoreData

class CityTableViewController: TableSearchViewController {
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CityTableViewController {
    
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

extension CityTableViewController {
    
    // MARK: Table Search View
    
    override func updateSearchResults(for searchController: UISearchController) {

        super.updateSearchResults(for: searchController)
        if filterCities.count < 1 {
            searchUsingAPI(searchText: searchController.searchBar.text)
        }
    }
    
    func searchUsingAPI(searchText: String?) {
        if let cityName = searchText {
            
            let request = SearchCityRequest(cityName: cityName)
            networking.sendRequest(request) { json, err in
                if let response = json {
                    let city = City(json: response)
                    self.filterCities = [city]
                    self.tableView.reloadData()
                }
            }
        }
    }
}
