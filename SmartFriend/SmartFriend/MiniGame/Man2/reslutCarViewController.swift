//
//  reslutCarViewController.swift
//  SmartFriend
//
//  Created by Hoang Thao on 6/30/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class reslutCarViewController: UIViewController {
    @IBOutlet weak var lbCorrect: UILabel!
    
    @IBOutlet weak var lbScore: UILabel!
    var Result:UserDefaults!
    var totalCorrectAnswers: Int = 0
    var totalAnswers: Int = 0
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.layer.cornerRadius=15
        btn2.layer.cornerRadius=15
        var txtCore=NSLocalizedString("Core:", comment: "")
        lbCorrect.text = txtCore + " \(totalAnswers)"
        var score = 0
        if(totalAnswers==0)
        {
            score = 0
        }
        else
        {
            score = 12*100/totalAnswers
            
        }
        lbScore.text = "\(score)%"
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "bgr1.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
}
