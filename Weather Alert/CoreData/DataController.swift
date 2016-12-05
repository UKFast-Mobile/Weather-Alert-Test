//
//  DataController.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 10/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit
import CoreData

class DataController {
    
    fileprivate lazy var applicationDocumentsDirectory: URL! = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }()
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel! = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator! = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
    
        let url = self.applicationDocumentsDirectory.appendingPathComponent("fastbook.sqlite")
        
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption : true,
                NSInferMappingModelAutomaticallyOption : true
            ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        
        return coordinator
    }()

    
    
    fileprivate(set) lazy var managedObjectContext: NSManagedObjectContext! = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    
    init() {}
    
    public func wasInitialised() -> Bool {
        guard applicationDocumentsDirectory != nil else { return false }
        guard managedObjectModel != nil else { return false }
        guard persistentStoreCoordinator != nil else { return false }
        return true
    }
}

extension DataController {
    
    static var dataController: DataController { return AppShared.instances.dataController }
    
    func store() {
        do {
            try DataController.dataController.managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func discard() {
        DataController.dataController.managedObjectContext.rollback()
    }
    
    func requestCoreData(entityName: String) -> [Any] {
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetched = try DataController.dataController.managedObjectContext.fetch(fetch)
            return fetched
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func fetchEntity(_ entityName: String, withPredicate predicate: NSPredicate? = nil, numberOfResultsLimit limit: Int? = nil) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        if let l = limit { request.fetchLimit = l }
        let results = try? DataController.dataController.managedObjectContext.fetch(request)
        return (results ?? []) as! [NSManagedObject]
    }
}
