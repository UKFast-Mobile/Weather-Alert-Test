//
//  Global.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 21/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation

struct AppShared {
    static var instances: AppShared = AppShared()
    public let networking = Networking(appId: "95fcc97498d7e406f5467cf3dc17f577")
    public let dataController = DataController()
    public let timeStampFormatter = TimeStampFormatter()
}

struct Constants {
    struct CellIdentifiers {
        static let CityDetailsTableViewCell: String = "CityDetailsTableViewCell"
        static let ForecastTableViewCell: String = "ForecastTableViewCell"
    }
}

struct TimeStampFormatter {
    
    let formatter = DateFormatter()
    
    func dateFormatter(date: TimeInterval) -> String {
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        let date = Date(timeIntervalSince1970: date)
        let result = String.localizedStringWithFormat("Date: %@", formatter.string(from: date))
        
        return result
    }
}
