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
    
    var cities: [City] = []
    
    // NOTE: Uncomment when merge
    var dataController = DataController()
//  var dataController: DataController { return AppShared.instances.dataController }
    
    // MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleCities()
    }
    
    func loadSampleCities() {
        
        let jsonResult = loadJson(jsonFile: "SeveralCities")
        let list = jsonResult!["list"] as? [[String : Any]]
        
        for (_, json) in list!.enumerated() {
            let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "City", in: dataController.managedObjectContext)
            let object = City(entity: entity!, insertInto: dataController.managedObjectContext)
            object.mapping(json: json)
            cities.append(object)
        }
    }
    
    func loadJson(jsonFile: String) -> [String : Any]? {
        
        guard let path = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
            let jsonData = try? Data(contentsOf: path, options: Data.ReadingOptions.mappedIfSafe),
            let jsonResult: [String : Any]? = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
            else { return nil }
        
        return jsonResult
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CityTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
        
        let city = cities[indexPath.row]
        
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
