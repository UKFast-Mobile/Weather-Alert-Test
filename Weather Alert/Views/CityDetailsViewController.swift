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
    
    var dataController: DataController = AppShared.instances.dataController

    var barButton: UIBarButtonItem?
    
    var tableModel: ForcastTableModel!
    var cityName: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//
//        guard let city = city else { return }
//        fetchNewCity()
//        tableModel = ForcastTableModel(city, table: tableView)
//        tableView.dataSource = tableModel
//        tableView.delegate = tableModel
//        
//        barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "starredImage"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(CityDetailsViewController.switchFavouriteStatus))
//        if let barButton = barButton {
//            self.navigationItem.rightBarButtonItem = barButton
//            
//            changeStarImage()
//        }
//

    }
    
    func switchFavouriteStatus() {
//        guard let city = city, let fav = city.favourite else { return }
//        city.favourite = ( fav as Bool ?  false : true )
//        changeStarImage()
//        dataController.store()
//        tableView.reloadData()
    }
    
    func changeStarImage() {
//        guard let city = city, let fav = city.favourite, let star = barButton else { return }
//        star.image = ( fav as Bool ? #imageLiteral(resourceName: "starredImage") : #imageLiteral(resourceName: "unstarredImage") )
    }
    
    fileprivate func fetchNewCity() {
//        guard let city = city, let tabView = self.tableView, let oldCityId = city.id else { return }
//        let cityRequest = SingleCityRequest(cityId: oldCityId)
//        if let response = cityRequest.response {
//            city.mapping(json: response)
//            self.dataController.store()
//            tabView.reloadData()
//        }
    }
}
