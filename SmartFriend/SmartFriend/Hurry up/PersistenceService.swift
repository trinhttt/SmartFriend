//
//  PersistenceService.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService{
    
    // Cai dat CoreData Persistence
    
    private init(){}
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
     
        //Ten cua coredata
        let container = NSPersistentContainer(name: "SmartFriend")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
        return container
    }()
    
    
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        
    }
    
}

