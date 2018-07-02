//
//  Device_or_DoworkTableViewCell.swift
//  SmartFriend
//
//  Created by Trinh Thai on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    
    var device: Device? {
        didSet {
            self.updateUI()
        }
    }
    func updateUI() {
        deviceImageView.image = UIImage(named: device!.image!)
        deviceNameLabel.text = device?.name
    }
    
}
