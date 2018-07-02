//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var delegate: AddItemViewControllerDelegate?
    
    var from: String?
    
    var editIndex: Int?
    
    var editItem: ChecklistItem?
    
    @IBAction func cancel() {
        
        delegate?.addItemViewControllerDidCancel(controller: self)
        
    }
    
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        let text: NSString = (textField.text as NSString?)!
        
        if text.length > 0 {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
        
    }
    
    @IBAction func done() {
        print(textField.text!)
        
        if(from == "Add"){
            let item = ChecklistItem(text: textField.text!)
            delegate?.addItemViewController(controller: self, didFinishAddingItem: item)
            DataModel.shared.save()
        }else if(from == "Edit"){
            let item = ChecklistItem(text: textField.text!)
            delegate?.editItemViewController(controller: self, item: item, index: editIndex!)
            DataModel.shared.save()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        
        if(from == "Edit"){
            self.title = "Edit item"
            textField.text = editItem?.text
            doneBarButton.isEnabled = true
        }
    }
    
    
}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func editItemViewController(controller: AddItemViewController, item: ChecklistItem, index: Int)
    
}
