//
//  MainViewController.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/25/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit
import AVFoundation

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet var checklistCollectionView: UICollectionView!
    @IBOutlet var addCheckListButton: UIBarButtonItem!
    @IBOutlet var infoLabel: UILabel!
    
    let maxCheckLists = 8
    
    ///them item
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard destinationIndexPath.item != 0 else { return }
        DataModel.shared.lists.insert(DataModel.shared.lists.remove(at: sourceIndexPath.item-1), at: destinationIndexPath.item-1)
    }
    
    ///bao nhieu nhom(1 loai item) trong collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///so luong item trong collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.lists.count + 1  // +1 la dong dau(de cang giua)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {// Cell rong
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath)
            return emptyCell
        } else {// Cell item
            let checklistCell = collectionView.dequeueReusableCell(withReuseIdentifier: "checklistCell", for: indexPath) as! CheckListCollectionViewCell
            let checklist = DataModel.shared.lists[indexPath.item-1]
            checklistCell.nameLabel.text = checklist.name
            //
            var detailText: String
            
            if(checklist.items.count == 0){
                detailText = "(No item)"
            }else if(checklist.countChecked() == checklist.items.count){
                detailText = "All done!!"
            }else{
                detailText = "\(checklist.countChecked())"+"/"+"\(checklist.items.count)"
                
            }
            checklistCell.detailTextLabel.text = detailText
            //
            checklistCell.tokenView.image = UIImage(named: checklist.iconName.rawValue)?.withRenderingMode(.alwaysTemplate)
            return checklistCell
        }
    }
    
    ///xac dinh kich thuoc item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 375, height: 16)//dong rong de cang giua,1/10 cho nho :)
        } else {
            return CGSize(width: 192, height: 166)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        let index = DataModel.shared.indexOfSelectedChecklist
        //        if index >= 0 && index < DataModel.shared.lists.count {
        //            let checklist = DataModel.shared.lists[index]
        //            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        //        }
    }
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let index = DataModel.shared.indexOfSelectedChecklist
    //            let checklist = DataModel.shared.lists[index]
    //            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    //
    //    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if(segue.identifier == "ShowChecklist"){
    //            let targetController = segue.destination as! ChecklistViewController
    //            let indexPath = DataModel.shared.indexOfSelectedChecklist
    //            targetController.list = DataModel.shared.lists[(indexPath)]
    //        }
    //    }
    
    
    /// Show alert & xu ly rename, delete item khi nhan giu~ 1item
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowChecklist"){
            let targetController = segue.destination as! ChecklistViewController//
            let cell = sender as? UICollectionViewCell
            let indexPath = checklistCollectionView.indexPath(for: cell!)
            targetController.list = DataModel.shared.lists[((indexPath?.item)!-1)]//-1 vi 0 la cai emptycell (da~ an?)
        }
    }
    var movingCell: UICollectionViewCell?
    
    @objc func handleLongPressGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        let movingIndexPath = checklistCollectionView.indexPathForItem(at: gestureRecognizer.location(in: checklistCollectionView))
        switch gestureRecognizer.state {
        case .began:
            guard let indexPath = movingIndexPath else { break }
            guard indexPath.item != 0 else { break }
            movingCell = checklistCollectionView.cellForItem(at: indexPath)
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                self.movingCell?.alpha = 0.7
                self.movingCell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: nil)
            checklistCollectionView.beginInteractiveMovementForItem(at: indexPath)
            ///
            
            if indexPath.item != 0 {
                let cell = checklistCollectionView.cellForItem(at: indexPath)!
                let checklist = DataModel.shared.lists[indexPath.item-1]//mang bat dau tu 0
                //show alert rename & delete
                let checklistAlertController = UIAlertController(title: "", message: "What do you wanna do with this checklist?", preferredStyle: .actionSheet)
                checklistAlertController.popoverPresentationController?.sourceView = cell.contentView
                checklistAlertController.popoverPresentationController?.sourceRect = cell.contentView.frame
                
                //xu ly rename action
                let renameAction = UIAlertAction(title: "Rename", style: .default, handler: { action in
                    let renameAlertController = UIAlertController(title: "Rename Checklist", message: "Enter a new name for \(checklist.name).", preferredStyle: .alert)
                    renameAlertController.addTextField(configurationHandler: { $0.autocapitalizationType = .words })
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                        if !renameAlertController.textFields!.first!.text!.isEmpty {
                            checklist.name = renameAlertController.textFields!.first!.text!
                            DataModel.shared.save()
                            self.checklistCollectionView.reloadData()
                        }
                    })
                    renameAlertController.addAction(okAction)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    renameAlertController.addAction(cancelAction)
                    self.present(renameAlertController, animated: true)
                })
                checklistAlertController.addAction(renameAction)
                
                //xu ly delete action
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                    DataModel.shared.lists.remove(at: indexPath.item-1)//xoa
                    DataModel.shared.save()
                    self.checklistCollectionView.reloadData()
                })
                checklistAlertController.addAction(deleteAction)
                
                //cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                checklistAlertController.addAction(cancelAction)
                present(checklistAlertController, animated: true)
            }
            
        ////
        default:
            checklistCollectionView.cancelInteractiveMovement()
            
        }
    }
    func configureNameFor(cell: UITableViewCell, withItem item: Checklist){
        var detailText: String
        cell.textLabel?.text = item.name
        if(item.items.count == 0){
            detailText = "(No item)"
        }else if(item.countChecked() == item.items.count){
            detailText = "All done!!"
        }else{
            detailText = "\(item.countChecked())"+"/"+"\(item.items.count)"
        }
        cell.detailTextLabel?.text = detailText
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        self.view.addGestureRecognizer(longPressGestureRecognizer)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checklistCollectionView.reloadData()
    }
    
    
}
