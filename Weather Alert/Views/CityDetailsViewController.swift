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
    
    var tableModel: ForcastTableModel!
    var city: City?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let city = city else { return }
        tableModel = ForcastTableModel(city, table: tableView)
        tableView.dataSource = tableModel
        tableView.delegate = tableModel
        
    }
    
}
