//
//  Device_or_DoworkDataSource.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

var devices : [Device]?

func initializeDevices() -> [Device]{
    let myTime = Time(context: PersistenceService.context)
    myTime.name = "Time"
    myTime.image = "Time"
    myTime.status = false
    myTime.mode = "Time"
    myTime.timer = 10.0
   
    PersistenceService.saveContext()

    let devices: [Device] = [myTime]
    return devices
}


