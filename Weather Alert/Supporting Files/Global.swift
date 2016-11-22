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
    public let networking = Networking(config: URLSessionConfiguration.default, appId: "95fcc97498d7e406f5467cf3dc17f577")
    public let dataController = DataController()
}
