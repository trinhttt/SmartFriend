//
//  Device+CoreDataProperties.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation
import CoreData

public class Device: NSManagedObject {

}
extension Device {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var status: Bool
    @NSManaged public var isFavorite: Bool
}

