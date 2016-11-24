//
//  SearchTableViewCell.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 24/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextFeild: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func search(_ sender: Any) {
    }

}
