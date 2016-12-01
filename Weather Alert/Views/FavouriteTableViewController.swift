//
//  FavourieTableViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 01/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit
import CoreData

class FavouriteTableViewController: UITableViewController {
    
    // MARK: Variables
    
    var dataController: DataController { return AppShared.instances.dataController }
    var cities: [City] {
        var cities: [City] = []
        var favourites: [City] = []
        let citiesFetch = NSFetchRequest<City>(entityName: "City")
        do {
            cities = try dataController.managedObjectContext.fetch(citiesFetch)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        for (_, city) in cities.enumerated() {
            
            if let fav = city.favourite {
                if fav as Bool {
                    favourites.append(city)
                }
            }
        }
        return favourites
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    @IBAction func searchEditingChanged(_ sender: UITextField) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FavouriteTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let test = sender as? CityTableViewCell {
            if let destinationVC = segue.destination as? CityDetailsViewController {
                destinationVC.city = test.city
            }
        }
    }
}

extension FavouriteTableViewController {
    
    // MARK: Table View
    
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
        cell.directionImage.image = city.windDirectionImage
        
        
        return cell
    }
}

extension FavouriteTableViewController: UISearchResultsUpdating {
    
    var searchIsActive: Bool {
        if searchController.isActive && searchController.searchBar.text != "" {
            return true
        } else {
            return false
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        searchUsingData(searchText: searchController.searchBar.text)
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
}

