//
//  CityDetailsViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    // MARK: Variables
    
    var cityFavourite: Bool?
    
    // MARK: Variables from prev view
    
    var cityId: NSNumber?
    
    // MARK: View objects
    
    @IBOutlet weak var tableView: UITableView!
    var tableModel: ForcastTableModel!
    var barButton: UIBarButtonItem?
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let cityId = cityId else { return }
        
        fetchNewCity(cityId: cityId)
        
//        tableModel = ForcastTableModel(city, table: tableView)
        
        tableView.dataSource = tableModel
        tableView.delegate = tableModel
        
        barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "starredImage"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CityDetailsViewController.switchFavouriteStatus))
        if let barButton = barButton {
            self.navigationItem.rightBarButtonItem = barButton
            changeStarImage()
        }
    }
    
    func switchFavouriteStatus() {
        guard let fav = cityFavourite else { return }
        cityFavourite = ( fav as Bool ?  false : true )
        changeStarImage()
        dataController.store()
        tableView.reloadData()
    }
    
    func changeStarImage() {
        guard let fav = cityFavourite, let star = barButton else { return }
        
        star.image = ( fav as Bool ? #imageLiteral(resourceName: "starredImage") : #imageLiteral(resourceName: "unstarredImage") )
    }
    
    func fetchNewCity(cityId: NSNumber) {
        let request = SingleCityRequest(cityId: cityId)
        
        networking.sendRequest(request) { json, err in
            if let response = json {
                let city = CoreCity(json: response)
                self.cityFavourite = city.favourite as? Bool
                self.tableView.reloadData()
            }
        }
    }
}
