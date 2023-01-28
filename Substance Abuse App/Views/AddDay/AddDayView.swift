//
//  AddDayView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 12/10/22.
//

import SwiftUI

struct AddDayView: View {
    var s: Substance
    
    @EnvironmentObject var manager : SubstanceManager
    
    @Environment(\.managedObjectContext) var context
    
    @Binding var currentPage : CurrentPage
    
    @State var date : Date = Date()
    @State var level : Int?
    @State var notes : String = ""
    @State var showingAlert : Bool = false
    @State var used : Bool?
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("BodyColor").ignoresSafeArea()
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 10) {
                        Text("New Daily Report")
                            .font(.title2)
                            .padding()
                        
                        DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding(.horizontal)
                        VStack(spacing: 48) {
                            
                            VStack {
                                Text("How would you rate your cravings today?")
                                HStack {
                                    ForEach(1..<11) { num in
                                        Button(action: {
                                            level = num
                                        }) {
                                            Text("\(num)")
                                                .foregroundColor(getColor(num))
                                                .fontWeight({num == level ? .heavy : .light}())
                                                .font(.title)
                                        }
                                    }
                                }
                            }
                            
                            VStack {
                                Text("Did you purchase \(s.name!.lowercased()) today?")
                                HStack {
                                    Spacer()
                                    Button(action: {used = false}) {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill((used == false ? Color(red: 0.05, green: 0.3, blue: 0.2): Color("MenuColor")))
                                            .frame(width: 96, height:48)
                                            .overlay() {
                                                Text("No")
                                                    .foregroundColor(Color.green)
                                                    .fontWeight(.bold)
                                            }
                                    }
                                    Spacer()
                                    Button(action: {
                                        used = true
                                    }) {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(used == true ? Color(red: 0.3, green: 0.1, blue: 0.1): Color("MenuColor"))
                                            .frame(width: 96, height:48)
                                            .overlay() {
                                                Text("Yes")
                                                    .foregroundColor(Color.red)
                                                    .fontWeight(.bold)
                                            }
                                    }
                                    Spacer()
                                }
                            }
                            
                            VStack {
                                Text("List some ways you could have avoided \(s.name!.lowercased()) today.")
                                    .multilineTextAlignment(.center)
                                TextField("", text: $notes, axis: .vertical)
                                    .padding()
                                    .background(Color("MenuColor"))
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                            }
                            
                            Button(action: {
                                if (level != nil && used != nil) {
                                    manager.addDate(s, rating: Int16(level!), notes: notes, date: Calendar.current.startOfDay(for: date), context: context)
                                    
                                    if (used == true ) {
                                        s.timesUsed += 1
                                        s.lastUsed = date
                                    }
                                    
                                    currentPage = CurrentPage.dash
                                } else {
                                    showingAlert = true
                                }
                                
                            }) {
                                Text("Submit")
                            }
                            .buttonStyle(.borderedProminent)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Error"), message: Text("You must select a craving level and whether or not you used this substance"), dismissButton: .default(Text("OK")))
                            }
                            Spacer()
                            
                            
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
    
    func getColor(_ n: Int) -> Color {
        switch(n) {
        case 8...Int.max:
            return Color.red
        case 4...7:
            return Color.yellow
        default:
            return Color.green
        }
    }
}

