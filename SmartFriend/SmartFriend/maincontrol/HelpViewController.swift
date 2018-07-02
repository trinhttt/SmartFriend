//
//  HelpViewController.swift
//  SmartFriend
//
//  Created by Hoang Thao on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var txtTextFied: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTextFied.text = NSLocalizedString("txtHelp", comment: "")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
