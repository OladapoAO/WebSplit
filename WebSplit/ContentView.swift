//
//  ContentView.swift
//  WebSplit
//
//  Created by Daps Owolabi on 28/10/2021.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var useRedText = false
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let total = totalPerPerson * Double(numberOfPeople + 2)
        return total
    }
    
    var body: some View {
        NavigationView{
        Form{
            
            Section{
                TextField("Amount", value: $checkAmount, format:.currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                Picker("Number of people", selection: $numberOfPeople){
                    ForEach(2..<100){
                        
                        Text("\($0) People")
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Section{
                
                Picker("Tip Precentage", selection: $tipPercentage){
                    ForEach(0..<101){
                        
                        Text($0, format: .percent)

                 }

                }
                
            } header:{
                Text("How much tip do you want to leave")
                 }
            
            Section{
                
                Text(totalAmount, format: localCurrency)
                    .foregroundColor(tipPercentage == 0 ? .red : .primary)
                
            } header: {
                Text("Total Amount")
            }
            
            
            Section {
                    Text(totalPerPerson, format: localCurrency)
            } header:{
                Text("Amount per person")
            }
            
           
            .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        
                            
        }.navigationTitle("WeSPlit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
                
        
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NotificationManager())
    }
}


