//
//  Checklist.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/27/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation

//class Checklist: NSObject, NSCoding{
//
//    var name: String
//    var items: [ChecklistItem]
//    var iconName: String
//
//    override init(){
//        self.name = ""
//        self.items = []
//        self.iconName = ""
//    }
//
//    init(name: String, items: [ChecklistItem] = []){
//        self.name = name
//        self.items = items
//        self.iconName = "No Icon"
//    }
//
//    init(name: String, items: [ChecklistItem] = [], iconName: String){
//        self.name = name
//        self.items = items
//        self.iconName = iconName
//    }
//
//    required convenience init(coder decoder: NSCoder) {
//        let name = decoder.decodeObject(forKey: "name") as? String
//        let items = decoder.decodeObject(forKey: "items") as? [ChecklistItem]
//        let iconName = decoder.decodeObject(forKey: "iconName") as? String
//        self.init(
//            name: name!,
//            items: items!,
//            iconName: iconName!
//        )
//    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(self.name, forKey: "name")
//        coder.encode(self.items, forKey: "items")
//        coder.encode(self.iconName, forKey: "iconName")
//    }
//
//    func countChecked()->Int{
//        var count = 0
//        for item in items {
//            if(item.checked){
//                count = count + 1
//            }
//        }
//        return count
//    }
//}
//
//  Checklist.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/26/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//
import Foundation
import UIKit
enum Token: String {
    case cannon = "cannon"
    case car = "car"
    case cat = "cat"
    case dog = "dog"
    case hat = "hat"
    case horse = "horse"
    case iron = "iron"
    case moneyBag = "money"
    case ship = "ship"
    case shoe = "shoe"
    case thimble = "thimble"
    case wheelbarrow = "wheelbarrow"
}

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.bounds.width/2
    }
    
}
class Checklist: NSObject,NSCoding {
    
    var name: String
    var iconName: Token
    var items : [ChecklistItem]
    override init(){
        self.name = ""
        self.items = []
        self.iconName = Token(rawValue: "")!
    }
    init(name: String, iconName: Token) {
        self.name = name
         self.items = []
        self.iconName = iconName
    }
    init(name: String, items: [ChecklistItem] = [], iconName: Token){
        self.name = name
        self.items = items
        self.iconName = iconName
    }
    // Methods to conform to NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
            let name = aDecoder.decodeObject(forKey: "name") as? String
            let items = aDecoder.decodeObject(forKey: "items") as? [ChecklistItem]
            let tokenRawValue = aDecoder.decodeObject(forKey: "iconName") as? String
        
        
        self.init(name: name!,  items: items!,iconName: Token(rawValue: tokenRawValue!)!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(items, forKey: "items")
        aCoder.encode(iconName.rawValue, forKey:"iconName")}
    
    func countItems() -> Int {
        
        return items.reduce(0) { count, item in count + (!item.checked ? 1 : 0) }
    }
    func countChecked()->Int{
        var count = 0
        for item in items {
            if(item.checked){
                count = count + 1
            }
        }
        return count
    }
}

