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
    
    var city: CoreCity?
    
    // MARK: Variables from prev view
    
    var sendCity: CityProtocol?
    
    // MARK: View objects
    
    @IBOutlet weak var tableView: UITableView!
    var tableModel: ForcastTableModel!
    var barButton: UIBarButtonItem?
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let city = sendCity else { return }
        
        updateCity(city)
        
        barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "starredImage"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CityDetailsViewController.switchFavouriteStatus))
        if let barButton = barButton {
            self.navigationItem.rightBarButtonItem = barButton
            changeStarImage()
        }
    }
    
    func switchFavouriteStatus() {
        guard let city = city, let fav = city.favourite else { return }
        city.favourite = ( fav as Bool ?  false : true )
        changeStarImage()
        dataController.store()
        tableView.reloadData()
    }
    
    func changeStarImage() {
        guard let city = city, let fav = city.favourite, let star = barButton else { return }
        
        star.image = ( fav.boolValue ? #imageLiteral(resourceName: "starredImage") : #imageLiteral(resourceName: "unstarredImage") )
    }
    
    func updateCity(_ city: CityProtocol) {
        
        guard let cityId = city.id else { return }
        
        let request = SingleCityRequest(cityId: cityId)
        
        networking.sendRequest(request) { [weak self] json, err in
            guard let strongSelf = self else { return }
            if let response = json {
                let city = CoreCity.cityFromJSON(response)
                strongSelf.city = city
                strongSelf.changeStarImage()
                strongSelf.tableModel = ForcastTableModel(for: city) { forecast in
                    
                    strongSelf.tableModel.forecast = forecast
                    
                    strongSelf.tableView.dataSource = strongSelf.tableModel
                    strongSelf.tableView.delegate = strongSelf.tableModel
                    strongSelf.dataController.store()
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
}
