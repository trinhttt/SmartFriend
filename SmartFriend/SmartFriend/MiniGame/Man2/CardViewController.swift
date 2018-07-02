//
//  CardViewController.swift
//  Challenge
//
//  Created by Thao Hoang on 5/24/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // var total=0
    var Core=0
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count+1) / 2
        }
    }
    
    private var emojiThemes = [
        ["🎃", "👻", "🤡", "👅", "🐃", "🍱", "🍩", "🎬", "🚌"],
        ["🏌🏻", "🏇", "🥈", "🚴🏽‍♀️", "⛹🏾‍♀️", "🤽🏻‍♀️", "🏄🏼‍♀️", "🏋️‍♀️", "🤼‍♂️"],
        ["🎹", "🥁", "🎼", "🎧", "🎷", "🎬", "🎤", "🎸", "🎻"]
    ]
    
    private lazy var randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
    private lazy var emojiChoices = emojiThemes[randomIndex]
    
    var emoji = [Int:String]()

    private(set) var flipCount = 0 {
        didSet {
            var txt=NSLocalizedString("Flips:", comment: "")
            flipCountLabel.text = txt+"\(flipCount)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBAction private func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender) {
            flipCount += 1
            game.chooseCard(at: cardNumber)
            if (game.finish() == true){
                //print("ket thuc")
                self.showResults()
            }
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor(patternImage: UIImage(named: "bgr3.jpg")!)
        self.view.contentMode=UIViewContentMode.scaleAspectFill
        self.view.clipsToBounds=true
        self.view.center=view.center
        print(emoji.count)
    }
    
    func startNewGame() {
        
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        emojiChoices = emojiThemes[randomIndex]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        
    }
    
    func addNewTheme(with emojiSet: [String]) {
        emojiThemes.append(emojiSet)
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
    }
    func showResults() {
        performSegue(withIdentifier: "resultSegue2", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! reslutCarViewController
        resultViewController.totalAnswers = flipCount
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
