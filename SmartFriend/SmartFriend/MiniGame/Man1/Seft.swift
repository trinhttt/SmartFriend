//
//  MainViewController.swift
//  SmartFriend
//
//  Created by Thao Hoang on 6/27/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class Seft: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "14.jpg")!)
        btn1.layer.cornerRadius=10
        btn2.layer.cornerRadius=10
        btn3.layer.cornerRadius=10
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
}
