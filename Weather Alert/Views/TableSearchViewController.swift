//
//  TableSearchViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 02/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

protocol DataAccessable {
    
    var dataController: DataController { get }
}

extension UIViewController: DataAccessable {
    
    var dataController: DataController { return AppShared.instances.dataController }
    var networking: Networking { return AppShared.instances.networking }
}

class TableSearchViewController: UITableViewController {
    
    // MARK: Variables
    
    var cities: [CoreCity] = []
    var filterCities: [CityProtocol] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
    
}

extension TableSearchViewController: UISearchResultsUpdating {
    
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

extension TableSearchViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? CityTableViewCell, let destinationVC = segue.destination as? CityDetailsViewController {
            destinationVC.sendCity = cell.city
        }
    }
}
