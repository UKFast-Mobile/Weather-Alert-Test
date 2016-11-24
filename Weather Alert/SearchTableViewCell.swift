//
//  SearchTableViewCell.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 24/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextFeild: UITextField!
    
    var dataController: DataController { return AppShared.instances.dataController }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    
    @IBAction func searchEndEdit(_ sender: UITextField) {
        
        if let cityName = searchTextFeild.text {
            
            let city = SearchCityRequest(cityName: cityName)
            city.response() { result in
                print(result)
                self.dataController.saveCities()
            }
        }
        else {
            print("Results could not be found")
        }
    }
    
    @IBAction func searchEditingChanged(_ sender: UITextField) {
        
//        if let cityName = searchTextFeild.text {
//            
//            let city = SearchCityRequest(cityName: cityName)
//            city.response() { result in
//                print(result)
//                result.saveCities()
//            }
//        }
//        else {
//            print("Results could not be found")
//        }
    }
}
