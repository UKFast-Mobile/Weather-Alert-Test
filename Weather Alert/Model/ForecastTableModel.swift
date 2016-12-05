//
//  ForecastTableModel.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 29/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class ForcastTableModel: NSObject {
    
    // MARK: Variables
    
    var city: CityProtocol
    var forecast: Forecast?
    weak var tableView: UITableView?
    
    // MARK: Functions
    
    init(for city: CityProtocol, completion: @escaping (Forecast?) -> Void) {
        
        self.city = city
        
        guard let cityId = city.id else { return }
        let forecastRequest = ForecastRequest(cityId: cityId)
        let networking = AppShared.instances.networking
        
        networking.sendRequest(forecastRequest) { json, err in
            if let response = json { completion(Forecast(json: response)) }
            else { completion(nil) }
        }
    }
}

extension ForcastTableModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let forecastData = forecast {
                return forecastData.forecast.count
            }
            else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.CityDetailsTableViewCell, for: indexPath) as? CityDetailsTableViewCell
                else { return UITableViewCell() }
            
            cell.cityLabel.text = city.name
            cell.countryLabel.text = city.country
            cell.directionLabel.text = city.directionLabel
            cell.speedLabel.text = city.windSpeedLabel
            cell.compassImage.image = city.windDirectionImage
            
            return cell
            
        case 1:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.ForecastTableViewCell, for: indexPath) as? ForecastTableViewCell
                else { return UITableViewCell() }
            
            if let forecastData = forecast {
                cell.directionLabel.text = forecastData.directionLabel(index: indexPath.row)
                cell.dateLabel.text = forecastData.dateLabel(index: indexPath.row)
                cell.speedLabel.text = forecastData.speedLabel(index: indexPath.row)
                cell.directionImage.image = forecastData.directionImage(index: indexPath.row)
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ForcastTableModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 435
        case 1:
            return 100
        default:
            return 5
        }
    }
}
