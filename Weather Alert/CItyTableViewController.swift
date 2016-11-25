//
//  CItyTableViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 22/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit
import CoreData

class CityTableViewController: UITableViewController {
    
    // MARK: Variables
        
    var dataController: DataController { return AppShared.instances.dataController }
    var cities: [City] {
        let citiesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        do { return try dataController.managedObjectContext.fetch(citiesFetch) as! [City] }
        catch { fatalError("Failed to fetch employees: \(error)") }
    }
    
    // MARK: UISearchController
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filterCities: [City] = []
    
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    @IBAction func searchEditingChanged(_ sender: UITextField) {
        dataController.saveCities()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let test = sender as? CityTableViewCell {
            print(test)
            if let name = test.nameLabel.text, let country = test.countryLabel.text {
                print(name)
                print(country)
            }
        }
        
    }
    
    // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchIsActive ? filterCities : cities ).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CityTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
        let city = (searchIsActive ? filterCities : cities )[indexPath.row]
        
        cell.city = city
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        
        return cell
    }
}

extension CityTableViewController: UISearchResultsUpdating {
    
    var searchIsActive: Bool {
        if searchController.isActive && searchController.searchBar.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func searchUsingData(searchText: String?, scope: String = "All") {
        
        filterCities = cities.filter { city in
            if let cityName = city.name, let lowerSearch = searchText?.lowercased() {
                return cityName.lowercased().contains(lowerSearch)
            }
            else {
                return false
            }
        }
        
        tableView.reloadData()
    }
    
    func searchUsingAPI(searchText: String?) {
        if let cityName = searchText, filterCities.count < 1, searchIsActive  {
            
            let city = SearchCityRequest(cityName: cityName)
            
            city.response() { result in
                
                if let resName = result.name {
                    
                    
                    self.searchUsingData(searchText: resName)
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        if self.filterCities.count == 1 {
                            self.dataController.saveCities()
                            self.filterCities = [result];
                            self.tableView.reloadData()
                        }
                            
                        else {
                            self.dataController.discardCities()
                            self.searchUsingData(searchText: resName)
                            self.tableView.reloadData()
                        }
                    });
                }
                
            }
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchUsingData(searchText: searchController.searchBar.text)
        searchUsingAPI(searchText: searchController.searchBar.text)
    }
}
