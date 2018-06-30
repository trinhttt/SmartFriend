//
//  DataModel.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/26/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation
class DataModel {
    static let shared = DataModel()
    var lists = [Checklist]()
    init() {
        if let checklistsData = UserDefaults.standard.object(forKey: "lists") as? Data {
            lists = NSKeyedUnarchiver.unarchiveObject(with: checklistsData) as! [Checklist]
        }
    }
    
    func save() {
        let checklistsData = NSKeyedArchiver.archivedData(withRootObject: lists)
        UserDefaults.standard.set(checklistsData, forKey: "lists")
    }
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    
    
//    func sortChecklists() {
//        lists.sort(by: { checklist1, checklist2 in
//            return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending
//        })
//    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    
    
    
}
