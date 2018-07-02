//
//  ResultChooseViewController.swift
//  SmartFriend
//
//  Created by Hoang Thao on 6/30/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class ResultChooseViewController: UIViewController {
    
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
        
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "bgr7.png")!)
        var txtCore=NSLocalizedString("Core:", comment: "")
        //lbAnswered.text = "Số câu đã trả lời: \(totalAnswers)"
        lbCorrect.text = txtCore + " \(totalAnswers)"
        //lbWrong.text = "Số câu đã trả lời SAI: \(totalAnswers - totalCorrectAnswers)"
        var score = 0
        if(totalAnswers==0)
        {
            score = 0
        }
        else
        {
            score = totalAnswers*100/totalCorrectAnswers
            
        }
        lbScore.text = "\(score)%"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
