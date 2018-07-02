//
//  FirstLaunch.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation
//tai va mo lan dau tien
final class FirstLaunch {
    let wasLaunchedBefore : Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init(getWasLaunchedBefore: () -> Bool,
         setWasLaunchedBefore: (Bool) -> ()) {
        let wasLaunchedBefore = getWasLaunchedBefore()
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            setWasLaunchedBefore(true)
        }
    }
    
    convenience init(userDefaults : UserDefaults, key : String) {
        self.init(getWasLaunchedBefore : {
            userDefaults.bool(forKey: key) },
                  setWasLaunchedBefore: { userDefaults.set($0, forKey: key)
        })
    }
}
