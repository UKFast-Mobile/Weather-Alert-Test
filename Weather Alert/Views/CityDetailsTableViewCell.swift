//
//  CityDetailsTableViewCell.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 29/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class CityDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var compassImage: UIImageView!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
