//
//  ForecastTableModel.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 29/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class ForcastTableModel: NSObject {
    
    let networking = AppShared.instances.networking
    
    let city: CoreCity
    weak var tableView: UITableView?
    var forecast: Forecast?
    
    init(_ aCity: CoreCity, table: UITableView?) {
        city = aCity
        tableView = table
        super.init()
        tableView?.dataSource = self
        tableView?.delegate = self
        fetchForecast()
    }
    
    fileprivate func fetchForecast() {
        if let cityId = city.id {
            
            let request = ForecastRequest(cityId: cityId)
            
            networking.sendRequest(request) { json, err in
                if let response = json {
                    self.forecast = Forecast(json: response)
                }
            }
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

private extension Forecast {
    
    func speedLabel(index: Int) -> String {
        let data = self.forecast[index]
        if let speed = data["speed"] {
            return "Speed: \(speed) mph"
        }
        return ""
    }
    
    func dateLabel(index: Int) -> String {
        let data = self.forecast[index]
        if let dt = data["dt"] as? Double {
            return AppShared.instances.timeStampFormatter.dateFormatter(date: dt)
        }
        return ""
    }
    
    func direction(index: Int) -> String {
        
        var direction: String = "Unknown"
        let data = self.forecast[index]
        
        if let direct = data["deg"] as? Int {
            
            if direct > 315 || direct <= 45 {
                direction = "North"
            } else if direct > 45 && direct <= 135 {
                direction = "East"
            } else if direct > 135 && direct <= 225 {
                direction = "South"
            } else if direct > 225 && direct <= 315 {
                direction = "West"
            }
        }
        return direction
    }
    
    
    func directionLabel(index: Int) -> String {
        return "Direction: \(direction(index: index))"
    }
    
    
    func directionImage(index: Int) -> UIImage? {
        return UIImage(named: "\(direction(index: index).lowercased())Image")
    }
}
