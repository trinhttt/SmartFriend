//
//  QuestionViewController.swift
//  Challenge
//
//  Created by Thao Hoang on 5/2/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController{
    var Question = ["1q.png","2q.png","3q.png","4q.png","5q.png","6q.png","7q.png","8q.png","9q.png","10q.png","11q.png","12q.png","13q.png","14q.png","15q.png","16q.png","17q.png","18q.png","19q.png","20q.png"]
    
    var Anser =  ["1a.png","2a.png","3a.png","4a.png","5a.png","6a.png","7a.png","8a.png","9a.png","10a.png","11a.png","12a.png","13a.png","14a.png","15a.png","16a.png","17a.png","18a.png","19a.png","20a.png"]
    var checkFalse = ["1f.png","2f.png","3f.png","4f.png","5f.png","6f.png","7f.png","8f.png","9f.png","10f.png","11f.png","12f.png","13f.png","14f.png","15f.png","16f.png","17f.png","18f.png","19f.png","20f.png"]
    var index=0
    var Core=0
    
    var total=0
    @IBOutlet weak var viTimer: UIView!
    //    @IBOutlet weak var lbQuestion: UILabel!
    // @IBOutlet weak var lbQuestion: UIImageView!
    // @IBOutlet var btAnswers: [UIButton]!
    let quizManager = QuestionManager()
    
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var imgQuestion: UIImageView!
    @IBAction func anserLeft(_ sender: Any) {
        total=total+1
        if(btnLeft.image(for: UIControlState.normal)==UIImage(named: Anser[index])){
            Core=Core+1
            index=index+1
            if(index>=3){
                index=Random(n: 16)+3
            }
            Game()
        }else{
            imgShow.image=UIImage(named: "no.png")
        }
        
    }
    @IBAction func anserRight(_ sender: Any) {
        total=total+1
        if(btnRight.image(for: UIControlState.normal)==UIImage(named: Anser[index])){
            Core=Core+1
            index=index+1
            if(index>=3){
                index=Random(n: 16)+3
            }
            Game()
        }else{
            imgShow.image=UIImage(named: "no.png")
            
        }
    }
    func Game(){
        imgShow.image=UIImage(named: "think.png")
        imgQuestion.image=UIImage(named: Question[index])
        if(Random(n: 2)==0){
            btnLeft.setImage(UIImage(named:Anser[index] ), for: UIControlState.normal)
            btnRight.setImage(UIImage(named:checkFalse[index] ), for: UIControlState.normal)
        }else{
            btnLeft.setImage(UIImage(named:checkFalse[index] ), for: UIControlState.normal)
            btnRight.setImage(UIImage(named:Anser[index] ), for: UIControlState.normal)
        }
        
    }
    func Random(n:Int)->Int{
        let randomIndex = Int(arc4random_uniform(UInt32(n)))
        return randomIndex
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Game()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "12.jpg")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viTimer.frame.size.width = view.frame.size.width
        UIView.animate(withDuration: 10.0, delay: 0, options: .curveLinear, animations: {
            self.viTimer.frame.size.width = 0
        }) { (success) in
            
            self.showResults()
        }
    }
    
    func showResults() {
        performSegue(withIdentifier: "resultSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultViewController
        resultViewController.totalAnswers = total
        resultViewController.totalCorrectAnswers = Core
    }
    
    
    
    
}
