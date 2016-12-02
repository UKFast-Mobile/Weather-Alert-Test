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
    
    // MARK: Variables
    
    var searchCities: [City] = []
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    @IBAction func searchEditingChanged(_ sender: UITextField) {
        dataController.store()
        self.tableView.reloadData()
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
        return (searchIsActive ? filterCities.count : cities.count )
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CityTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
        
        if searchIsActive {
            return cellUsingCity(cell: cell, city: searchCities[indexPath.row])
        }
        else {
            return cellUsingCity(cell: cell, city: cities[indexPath.row])
        }
    }
    
    func cellUsingCity(cell: CityTableViewCell, city: City) -> CityTableViewCell {
        
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        cell.directionImage.image = city.windDirectionImage
        
        return cell
        
    }
    
    func cellUsingCity(cell: CityTableViewCell, city: CoreCity) -> CityTableViewCell {
        
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        cell.directionImage.image = city.windDirectionImage
        
        return cell
        
    }
}

extension CityTableViewController {
    
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
                    self.searchCities = [city]
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension CityTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? CityTableViewCell {
            if let destinationVC = segue.destination as? CityDetailsViewController {
                destinationVC.cityName = cell.nameLabel.text
            }
        }
    }
}
