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

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (activeSearch ? filterCities : cities ).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CityTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
        let city = (activeSearch ? filterCities : cities )[indexPath.row]
        
        
        cell.directionLabel.text = city.direction
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        
        if let degree = city.deg?.stringValue {
            cell.degLabel.text = degree + "°"
        } else {
            cell.degLabel.text = "Unknown"
        }
        
        if let spd = city.speed?.stringValue {
            cell.speedLabel.text = spd + " mph"
        } else {
            cell.speedLabel.text = "Unknown"
        }
        
        return cell
    }
}

extension CityTableViewController: UISearchResultsUpdating {
    
    var activeSearch: Bool {
        if searchController.isActive && searchController.searchBar.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func filterContentForSearchText(searchText: String?, scope: String = "All") {
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
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text)
    }
    
}
