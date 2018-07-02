//
//  Time+CoreDataClass.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation
import CoreData

public class Time: Device {
    
}
public class Study: Device {
    
}
public class Cook: Device {
    
}
public class Exe: Device {
    
}
extension Time {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Time> {
        return NSFetchRequest<Time>(entityName: "Time")
    }
    
    @NSManaged public var mode: String?
    @NSManaged public var timer: Double
    
}
