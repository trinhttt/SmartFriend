//
//  AddCheckListViewController.swift
//  SmartFriend
//
//  Created by Trinh Thai on 6/25/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//


import UIKit

class AddCheckListViewController: UITableViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var tokenCollectionView: UICollectionView!
    
    var selectedToken = 0
    let tokens = ["cannon", "car", "cat", "dog", "hat", "horse", "iron", "money", "ship", "shoe", "thimble", "wheelbarrow"]
    
    /// append 1 checklist vao danh sach
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            let name = nameTextField.text!.isEmpty ? "CheckList" : nameTextField.text!
            let checklist = Checklist(name: name,items: [ChecklistItem](), iconName: Token(rawValue: tokens[selectedToken])!)
            DataModel.shared.lists.append(checklist)
            DataModel.shared.save()
            let mainViewController = navigationController?.viewControllers.first as! ListViewController
            mainViewController.checklistCollectionView.reloadData()
            navigationController?.popViewController(animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 0 {
            return 56*2 + 30 //chieucao*2(dong) + khoang cach vs bottom
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 25
        } else {
            return 5
        }
    }
    
    ///bao nhieu nhom(1 loai item) trong collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ///so luong icon
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    ///xu ly chon icon
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tokenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tokenCell", for: indexPath) as! TokenCollectionViewCell
        let isSelected = indexPath.item == selectedToken
        let tokenName = isSelected ? tokens[indexPath.item] + "_filled" : tokens[indexPath.item]
        tokenCell.tokenView.image = UIImage(named: tokenName)!.withRenderingMode(.alwaysTemplate)
        let affineTransform = isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform.identity
        UIView.animate(withDuration: 0.1, animations: {
            tokenCell.transform = affineTransform
        })
        return tokenCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedToken = indexPath.item
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 56)
    }
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
}
