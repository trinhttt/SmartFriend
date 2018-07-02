//
//  ResultViewController.swift
//  Challenge
//
//  Created by Thao Hoang on 5/4/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var lbCorrect: UILabel!
    
    @IBOutlet weak var lbScore: UILabel!
    var Result:UserDefaults!
    var totalCorrectAnswers: Int = 0
    var totalAnswers: Int = 0
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var txtCore=NSLocalizedString("Core:", comment: "")
        btn1.layer.cornerRadius=15
        btn2.layer.cornerRadius=15
        //lbAnswered.text = "Số câu đã trả lời: \(totalAnswers)"
        lbCorrect.text = txtCore + " \(totalCorrectAnswers)"
        //lbWrong.text = "Số câu đã trả lời SAI: \(totalAnswers - totalCorrectAnswers)"
        var score = 0
        if(totalAnswers==0)
        {
            score = 0
        }
        else
        {
            score = totalCorrectAnswers*100/totalAnswers
            
        }
        lbScore.text = "\(score)%"
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "12.png")!)
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
