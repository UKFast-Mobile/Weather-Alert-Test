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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        if let sits = city {
            titleLabel.text = sits.name
            countyLabel.text = sits.country
            directionImage.image = UIImage(named: "\(sits.direction.lowercased())Image")
            directionLabel.text = "Wind Direction: \(sits.direction)"
            if let speed = sits.speed?.stringValue {
                speedLabel.text = "Wind Speed: \(speed)"
            }
        }
        print(childViewControllers.count)
    }
    
    // MARK: Actions
    
}
