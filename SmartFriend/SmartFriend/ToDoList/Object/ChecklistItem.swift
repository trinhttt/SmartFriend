//
//  ChecklistItem.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/27/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//
import Foundation

class ChecklistItem: NSObject, NSCoding {
    
    var text: String
    var checked: Bool
    init(text: String){
        self.text = text
        self.checked = false
    }
    
    init(text: String, checked: Bool){
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked(){
        if(self.checked){
            self.checked = false
        }else{
            self.checked = true
        }
    }
        
    required convenience init(coder decoder: NSCoder) {
        let checked = decoder.decodeBool(forKey: "checked")
        let text = decoder.decodeObject(forKey: "text") as? String
        
        self.init(
            text: text!,
            checked: checked
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.text, forKey: "text")
        coder.encode(self.checked, forKey: "checked")
    }
    
}
