//
//  FullcastRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

class FullcastRequest: NetworkingRequest {
    
    var result: Fullcast?
    
    init(cityId: Int) {
        let path = "/forecast/daily?id=\(cityId)"
        super.init(path: path)
        
        fetchData() { fetched in
            if let res = fetched {
                self.result = res
            }
        }
    }
    
    func fetchData(completionHandler: @escaping (Fullcast?) -> Void) {
        super.handleResponse() { res in
            if let result = res {
                let object = Fullcast(json: result)
                completionHandler(object)
            }
            else {
                completionHandler(nil)
            }
        }
    }
}
