//
//  ForecastTableViewCell.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
