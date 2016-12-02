//
//  TableSearchViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 02/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit


class TableSearchViewController: UITableViewController {
    
    // MARK: Variables
    
    var cities: [CoreCity] = []
    var filterCities: [CoreCity] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
