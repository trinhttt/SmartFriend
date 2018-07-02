//
//  ChooseViewController.swift
//  Challenge
//
//  Created by Hoang Thao on 6/1/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    var emoji = ["cachua.png","cam.png","dau.png","kiwi.png","dudu.png","nho.png"]
    var inDex:Int=7
    var ImgArr = [UIImageView]()
    var imageAray=[UIImage]()
    var image = [UIImageView]()
    var index1:Int?
    var index2:Int?
    var Core:Int?
    var total=0
    //@IBOutlet weak var time: UIView!
    
    
    
    @IBOutlet weak var time: UIView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    //  @IBOutlet weak var lbCore: UILabel!
    
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var imgRight: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        time.frame.size.width = view.frame.size.width
        UIView.animate(withDuration: 10.0, delay: 0, options: .curveLinear, animations: {
            self.time.frame.size.width = 0
        }) { (success) in
            
            self.showResults()
        }
        
        
    }
    @IBAction func btnLeft(_ sender: Any) {
        var index2=inDex;
        var check = inDex-1
        if (imgLeft.image == ImgArr[check].image ){
            total=total+1
            Core = Core!+1
            //  lbCore.text=String(Core!)
            for i in 0..<check{
                ImgArr[check-i].image=ImgArr[check-i-1].image
                if(i==0){
                    ImgArr[0].image=UIImage(named: "")
                }
            }
            index2 = index2-1
            if(ImgArr[6].image == UIImage(named: "")){
                FirstGame()
                return
            }
            
            let changeImg=Random(n: 2)
            if(changeImg==0){
                var temp:UIImage?
                temp=imgLeft.image
                imgLeft.image=imgRight.image
                imgRight.image=temp
            }
        }
        
    }
    @IBAction func btnRight(_ sender: Any) {
        total=total+1
        var index2=inDex
        var check = inDex-1
        if (imgRight.image == ImgArr[check].image ){
            Core = Core!+1
            // lbCore.text=String(Core!)
            for i in 0..<check{
                ImgArr[check-i].image=ImgArr[check-i-1].image
                if(i==0){
                    ImgArr[0].image=UIImage(named: "")
                }
            }
            index2 = index2-1
            if(ImgArr[6].image == UIImage(named: "")){
                FirstGame()
                return
            }
            let changeImg=Random(n: 2)
            if(changeImg==0){
                var temp:UIImage?
                temp=imgLeft.image
                imgLeft.image=imgRight.image
                imgRight.image=temp
            }
        }
    }
    
    
    
    func showResults() {
        performSegue(withIdentifier: "resultSegue3", sender: nil)
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "19.jpg")!)
        // print("finish")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultChooseViewController
        resultViewController.totalAnswers = Core!
        resultViewController.totalCorrectAnswers = total
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "19.jpg")!)
        // lbCore.text="0"
        Core=0
        for i in 0..<emoji.count{
            var ss = UIImage(named: emoji[i])
            imageAray.append(ss!)
        }
        ImgArr.append(img1)
        ImgArr.append(img2)
        ImgArr.append(img3)
        ImgArr.append(img4)
        ImgArr.append(img5)
        ImgArr.append(img6)
        ImgArr.append(img7)
        FirstGame()
        
        // Do any additional setup after loading the view.
    }
    
    func FirstGame(){
        index1=Random(n: emoji.count)
        index2=Random(n: emoji.count)
        while index2==index1 {
            index2=Random(n: emoji.count)
        }
        imgLeft.image=imageAray[index1!]
        imgRight.image=imageAray[index2!]
        
        var countShow = Random(n: 5)
        countShow = countShow+2
        for i in 0..<countShow
        {
            let rand=Random(n: 2)
            if(rand==0){
                ImgArr[ImgArr.count-i-1].image=imageAray[index1!]
            }
            else{
                ImgArr[ImgArr.count-i-1].image=imageAray[index2!]
            }
        }
    }
    func Random(n:Int)->Int{
        let randomIndex = Int(arc4random_uniform(UInt32(n)))
        return randomIndex
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
