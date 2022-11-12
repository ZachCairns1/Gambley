//
//  ContentView.swift
//  Gambley
//
//  Created by Zach Cairns on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    @State var current = ""
    @State var money: Int = 100
    @State var reset = false
    @State var submitted = false
    
    @State var rolls: Int = 0
    @State var computerRolls: [Int] = []
    @State var yourRolls: [Int] = []
    
    @State var computerRoll = 0
    @State var yourRoll = 0
    
    @State var compSum = 0
    @State var yourSum = 0
    
    var body: some View {
        VStack{
            Text("GAMBLEY")
                .font(.system(size: 36, weight: .black, design: .serif))
            NavigationStack {
                VStack {
                    if(!submitted) {
                        Form{
                            Text("**Rules:**")
                            Text("1. Place your wager. ")
                            Text("2. Select number of dice to roll")
                            Text("3. Roll your dice.")
                            HStack{
                                Text("Enter name: ")
                                TextField("Enter your name", text: $current)
                                    .border(.secondary)
                                    .autocorrectionDisabled()
                                    .onSubmit {
                                        name = current
                                    }
                            }
                            VStack{
                                Text("Choose number rolls")
                                Picker("Rolls", selection: $rolls) {
                                    ForEach(1...10, id: \.self) { number in
                                        Text("\(number)")
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                            }
                            Button {
                                submitted = true
                            } label: {
                                Text("                               ROLL").bold()
                            }
                        }
                        
                    }
                    else {
                        Text("Rolls left: \(rolls)")
                        Button {
                            if(rolls > 0) {
                                computerRoll = Int.random(in: 1..<7)
                                computerRolls.append(computerRoll)
                                compSum += computerRoll
                                
                                yourRoll = Int.random(in: 1..<7)
                                yourRolls.append(yourRoll)
                                yourSum += yourRoll
                                
                                rolls -= 1
                            }
                        } label: {
                            Text("Roll")
                        }
                        Spacer()
                        HStack{
                            List {
                                Section {
                                    Text("Comp score: \(compSum)")
                                    ForEach(computerRolls, id: \.self) { task in
                                        Text("Roll: \(task):")
                                    }
                                }
                            }
                            .frame(maxHeight: 550)
                            List {
                                Section {
                                    Text("Your score: \(yourSum)")
                                    ForEach(yourRolls, id: \.self) { task in
                                        Text("Roll: \(task)")
                                    }
                                }
                            }
                            .frame(maxHeight: 550)
                            
                        }
                        Text("HAHAHAHHAAHHA")
                    }
                    HStack{
                        Text("Player: " + name)
                            .padding(.trailing, 20)
                        Text("Money: $\(money)")
                            .padding(.trailing, 50)
                        Button("reset", action: {
                            reset = true
                            submitted = false
                            money = 100
                            name = ""
                            rolls = 0
                            computerRolls.removeAll()
                            yourRolls.removeAll()
                            compSum = 0
                            yourSum = 0
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
