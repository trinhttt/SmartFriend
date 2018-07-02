//
//  Concentration.swift
//  Challenge
//
//  Created by Thao Hoang on 5/24/18.
//  Copyright © 2018 Trinh Thai. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }

        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceCard = index
            }
            
        }
    }
    
    func finish()->Bool{
        for i in 0..<cards.count{
            if (cards[i].isMatched==false){
                return false
            }
        }
        return true;
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "init(\(numberOfPairsOfCards)): you must have at least 1 pair of cards")
        var card1 = [Card]()
        var card2 = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            card1.append(card)
            card2.append(card)
            
        }
        for _ in 1...numberOfPairsOfCards {
            var i=Random(n: numberOfPairsOfCards-1);
            var dem=0
            while(card1[i].identifier == -1){
                dem=dem+1
                if (dem<4){
                    i=Random(n: numberOfPairsOfCards-1)
                }else{
                    i=i+1
                    if (i>5){
                        i=0
                    }
                }
                
            }
            var j=Random(n: numberOfPairsOfCards-1);
            while(card2[j].identifier == -1){
                dem=dem+1
                if (dem<4){
                    j=Random(n: numberOfPairsOfCards-1)
                }else{
                    j=j+1
                    if (j>5){
                        j=0
                    }
                }
            }
            cards.append(card1[i])
            cards.append(card2[j])
            card1[i].identifier = -1
            card2[j].identifier = -1
        }
        
    }
    func Random(n:Int)->Int{
        let randomIndex = Int(arc4random_uniform(UInt32(n)))
        return randomIndex
    }
}
