//
//  LanguageViewController.swift
//  SmartFriend
//
//  Created by Hoang Thao on 7/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "bgr5.png")!)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnEnglish(_ sender: Any) {
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(0)
    }
    
    @IBAction func btnVietnamses(_ sender: Any) {
        UserDefaults.standard.set(["vi"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
         exit(0)
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
