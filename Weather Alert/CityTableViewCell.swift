//
//  CityTableViewCell.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 22/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit
import CoreData

class CityTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var city: City?

    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
