//
//  NetworkingRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 24/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

protocol NetworkingRequest {
    
    // MARK: Variables
    
    var path: String { get set }
    
}

extension NetworkingRequest {
    
    var networking: Networking { return AppShared.instances.networking }
    var dataController: DataController { return AppShared.instances.dataController }
}
