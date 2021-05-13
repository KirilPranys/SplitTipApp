//
//  ContentView.swift
//  WeSplit
//
//  Created by Kiril Pranys on 04.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPeson: Double{
        // calculus
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelecetion = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelecetion
        let grandTotal = orderAmount + tipValue
        let amountPerPeron = grandTotal / peopleCount
        
        return amountPerPeron
    }
    
    var body: some View {
        NavigationView{
                    VStack{
                        Form{
                            Section{
                                TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
                                Picker("Number of people", selection:
                                        $numberOfPeople){
                                    ForEach(2..<10){
                                        Text("\($0) people")
                                    }
                                }
                            }
                                
                            Section(header: Text("How much u would like to donate")){
                                Picker("Tip Percentage", selection:
                                    $tipPercentage){
                                        ForEach(0 ..< tipPercentages.count){
                                            Text("\(self.tipPercentages[$0])%")
                                        }
                                }.pickerStyle(SegmentedPickerStyle())
                                }
                            Section{
                                Text("$\(totalPerPeson, specifier: "%.2f")")
                            }
                        }.navigationBarTitle("WeSplit V1.0")
                    }.background(AnimatedBackground().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }
    }
}


struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.red, Color.purple, Color.pink, Color.yellow, Color.green, Color.orange]
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
