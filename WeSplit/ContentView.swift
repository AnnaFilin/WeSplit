//
//  ContentView.swift
//  WeSplit
//
//  Created by Anna Filin on 24/09/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [ 10,15,20,25,0]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                   
                }
//                Section("How much do you want to tip?") {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
                Section("How much do you want to tip?") {
                                    NavigationLink {
                                        TipSelectionView(tipPercentage: $tipPercentage)
                                    } label: {
                                        Text("Tip: \(tipPercentage)%")
                                    }
                                }
                Section("Amount per person") {
                    
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount for check") {
                    
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct TipSelectionView: View {
    @Binding var tipPercentage: Int
    
    var body: some View {
        Form {
            Picker("Tip Percentage", selection: $tipPercentage) {
                ForEach(0..<101) { // Wider range: 0% to 100%
                    Text("\($0)%")
                }
            }
            .pickerStyle(.wheel) // Use a wheel picker style for selection
        }
        .navigationTitle("Select Tip")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
