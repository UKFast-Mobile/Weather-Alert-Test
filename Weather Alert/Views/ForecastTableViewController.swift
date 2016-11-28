//
//  ForecastTableViewController.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    
    // MARK: Variables
    
    let city = FullcastRequest(cityId: 2172797).result

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ForecastTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ForecastTableViewCell
        
        cell.directionLabel.text = String(indexPath.row)
        cell.speedLabel.text = "1"
        cell.dateLabel.text = "1"
        
        
        return cell
    }

}
