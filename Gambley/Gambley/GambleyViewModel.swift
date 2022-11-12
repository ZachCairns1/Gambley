//
//  GambleyViewModel.swift
//  Gambley
//
//  Created by Zach Cairns on 11/12/22.
//

import SwiftUI

class GambleyViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var current = ""
    @Published var money: Int = 100
    @Published var reset = false
    @Published var submitted = false
    
    @Published var rolls: Int = 0
    @Published var computerRolls: [Int] = []
    @Published var yourRolls: [Int] = []
    
    @Published var computerRoll = 0
    @Published var yourRoll = 0
    
    @Published var compSum = 0
    @Published var yourSum = 0
    
    @Published var wager = 0
    @Published var tempWager = 0
    
    
    
    func rollDie() {
        if(rolls > 0) {
            computerRoll = Int.random(in: 1..<7)
            computerRolls.append(computerRoll)
            compSum += computerRoll
            
            yourRoll = Int.random(in: 1..<7)
            yourRolls.append(yourRoll)
            yourSum += yourRoll
            
            rolls -= 1
        }
    }
    
    func resetGame() {
        reset = true
        submitted = false
        money = 100
        name = ""
        rolls = 0
        computerRolls.removeAll()
        yourRolls.removeAll()
        compSum = 0
        yourSum = 0
        wager = 0
        current = ""
        tempWager = 0
    }
    
    func payOut(){
        
    }
}
