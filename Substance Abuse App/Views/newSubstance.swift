//
//  newSubstance.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 12/11/22.
//

import SwiftUI

struct newSubstance: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var manager : SubstanceManager
    
    @Environment(\.managedObjectContext) var context
    
    
    @State var name = ""
    @State var price = ""
    @State var howOften = ""
    @State var showingAlert = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("BodyColor")
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("New Substance")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        VStack {
                            Text("What substance would you like to quit?")
                                .multilineTextAlignment(.center)
                            TextField("Name", text: $name)
                                .padding()
                                .background(Color("MenuColor"))
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        VStack {
                            Text("What is the price of the substance?")
                                .multilineTextAlignment(.center)
                            TextField("Price", text: $price)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color("MenuColor"))
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        VStack {
                            Text("How many days usually goeas in between purchases")
                                .multilineTextAlignment(.center)
                            
                            TextField("7", text: $howOften)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color("MenuColor"))
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            if (name == "" || price == "" || howOften == "" ) {
                                showingAlert = true
                            } else {
                                manager.NewSubstance(name, Double(price)!, Int16(howOften)!, context: context)
                                try? context.save()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Submit")
                            
                            .frame(width: abs(geometry.size.width-32), height: 48)
                        }
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                        .padding()
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("You must fill in all fields"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                .onTapGesture {
                    self.hideKeyboard()
                    
                }
            }
        }
    }
    func hideKeyboard() {
            let resign = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
}

struct newSubstance_Previews: PreviewProvider {
    static var previews: some View {
        newSubstance()
    }
}
