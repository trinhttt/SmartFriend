//
//  ChecklistViewController.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/27/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    
    var list: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list.name
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var button: UIBarButtonItem!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddItem" ){
            let destinationNavigationController = segue.destination as? UINavigationController
            let targetController = destinationNavigationController?.topViewController as! AddItemViewController
            targetController.delegate = self
            targetController.from = "Add"
        }else if(segue.identifier == "EditItem" ){
            let destinationNavigationController = segue.destination as? UINavigationController
            let targetController = destinationNavigationController?.topViewController as! AddItemViewController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell!)
            targetController.delegate = self
            targetController.from = "Edit"
            targetController.editIndex = indexPath?.row
            targetController.editItem = list.items[(indexPath?.row)!]
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureTextFor(cell: cell, withItem: list.items[indexPath.row])
        configureCheckmarkFor(cell: cell, withItem: list.items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list.items[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func configureCheckmarkFor(cell: UITableViewCell, withItem item: ChecklistItem){
        if(item.checked){
            let label = cell.viewWithTag(1) as! UILabel
            label.isHidden = false
        }else{
            let label = cell.viewWithTag(1) as! UILabel
            label.isHidden = true
        }
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: ChecklistItem){
        let label = cell.viewWithTag(2) as! UILabel
        label.text = item.text
    }
    
    
}

//AddItemViewControllerDelegate
extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem){
        dismiss(animated: true, completion: nil)
        list.items.append(item)
        let indexPath = IndexPath(row: list.items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func editItemViewController(controller: AddItemViewController, item: ChecklistItem, index: Int) {
        dismiss(animated: true, completion: nil)
        list.items[index] = item
        tableView.reloadData()
    }
}




