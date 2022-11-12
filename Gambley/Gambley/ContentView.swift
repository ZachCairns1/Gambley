//
//  ContentView.swift
//  Gambley
//
//  Created by Zach Cairns on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = GambleyViewModel()
    
    var body: some View {
        VStack{
            Text("GAMBLEY")
                .font(.system(size: 36, weight: .black, design: .serif))
            NavigationStack {
                VStack {
                    if(!vm.submitted) {
                        Form{
                            Text("**Rules:**")
                            Text("1. Select number of dice to roll.")
                            Text("2. Roll your dice and beat the computer!")
                            Text("3. Place your wager. ")
                            HStack{
                                Text("Enter name: ")
                                TextField("Enter your name", text: $vm.current)
                                    .border(.secondary)
                                    .autocorrectionDisabled()
                                    .onSubmit {
                                        vm.name = vm.current
                                    }
                            }
                            VStack{
                                Text("Choose number rolls")
                                Picker("Rolls", selection: $vm.rolls) {
                                    ForEach(0...10, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                            }
                            HStack{
                                Text("Enter wager: ")
                                TextField("Enter your score", value: $vm.tempWager, format: .number)
                                    .border(.secondary)
                                    .onSubmit {
                                        vm.wager = vm.tempWager
                                    }
                            }
                            Button {
                                if(vm.wager > 0 && vm.name != "" && vm.rolls > 0){
                                    if (vm.wager <= vm.money){
                                        vm.submitted = true
                                    }
                                }
                            } label: {
                                Text("                               ROLL").bold()
                            }
                        }
                        
                    }
                    else {
                        ZStack{
                            VStack{
                                Text("Rolls left: \(vm.rolls)")
                                Button {
                                    if(vm.rolls > 0 && vm.rolls != 1) {
                                        vm.rollDie()
                                    }
                                    else if(vm.rolls == 1) {
                                        vm.rollDie()
                                        if (vm.compSum >= vm.yourSum) {
                                            //You lose lol.
                                            vm.money -= vm.wager
                                        }
                                        else{
                                            vm.money += vm.wager
                                        }
                                    }
                                } label: {
                                    Text("Roll")
                                }
                                Spacer()
                                HStack{
                                    List {
                                        Section {
                                            Text("**Comp score: \(vm.compSum)**")
                                                .font(.system(size: 18))
                                            ForEach(vm.computerRolls, id: \.self) { task in
                                                Text("Roll: \(task)")
                                            }
                                        }
                                    }
                                    .frame(maxHeight: 550)
                                    List {
                                        Section {
                                            Text("**Your score: \(vm.yourSum)**")
                                                .font(.system(size: 18))
                                            ForEach(vm.yourRolls, id: \.self) { task in
                                                Text("Roll: \(task)")
                                            }
                                        }
                                    }
                                    .frame(maxHeight: 550)
                                    
                                }
                            }
                            if(vm.rolls == 0) {
                                Rectangle().fill(Color.black)
                                    .frame(width: 300, height: 300)
                                if (vm.compSum >= vm.yourSum) {
                                    VStack {
                                        Text("**Computer: \(vm.compSum), You: \(vm.yourSum)**")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30.0))
                                            .padding(.bottom, 30)
                                        Text("You Lost $\(vm.wager)")
                                            .foregroundColor(.red)
                                            .font(.system(size: 30.0))
                                            .padding(.bottom, 30)
                                        Text("Your Updated Total: $\(vm.money)")
                                            .foregroundColor(.red)
                                            .font(.system(size: 24.0))
                                            .padding(.bottom, 30)
                                        Button {
                                            vm.submitted = false
                                            vm.tempWager = 0
                                            vm.compSum = 0
                                            vm.yourSum = 0
                                            vm.wager = 0
                                            vm.yourRolls.removeAll()
                                            vm.computerRolls.removeAll()
                                        } label: {
                                            Text("Play Again?")
                                                .foregroundColor(.blue)
                                                .font(.system(size: 24.0))
                                        }
                                    }
                                } else {
                                    VStack {
                                        Text("**Computer \(vm.compSum), You: \(vm.yourSum)**")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30.0))
                                            .padding(.bottom, 30)
                                        Text("You Won $\(vm.wager)!!!")
                                            .foregroundColor(.green)
                                            .font(.system(size: 24.0))
                                            .padding(.bottom, 30)
                                        Text("Your Updated Total: $\(vm.money)")
                                            .foregroundColor(.green)
                                            .font(.system(size: 24.0))
                                            .padding(.bottom, 30)
                                        Button {
                                            vm.submitted = false
                                            vm.tempWager = 0
                                            vm.compSum = 0
                                            vm.yourSum = 0
                                            vm.wager = 0
                                            vm.yourRolls.removeAll()
                                            vm.computerRolls.removeAll()
                                        } label: {
                                            Text("Play Again?")
                                                .foregroundColor(.blue)
                                                .font(.system(size: 24.0))
                                        }
                                    }
                                }
                                
                            }
                        }
                            
                        
                    }
                    HStack{
                        Text("Player: " + vm.name)
                            .foregroundColor(.red)
                            .padding(.trailing, 0)
                        Text("Money: $\(vm.money)")
                            .padding(.trailing, 0)
                            .foregroundColor(.green)
                        Text("Current Wager: \(vm.wager)")
                            .foregroundColor(.purple)
                        Button("End game", action: {
                            vm.resetGame()
                        })
                    }
                }
            }
        }
    }
}


struct diceView: View {
    var body: some View {
        Text("Dice")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

