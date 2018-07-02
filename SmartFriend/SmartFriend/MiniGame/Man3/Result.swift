//
//  Result.swift
//  SmartFriend
//
//  Created by Hoang Thao on 6/28/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class Result: UIViewController {

    @IBOutlet weak var lbAnswered: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    
    var totalCorrectAnswers: Int = 0
    var totalAnswers: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbAnswered.text = "Số điểm của bạn: \(totalAnswers)"
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
