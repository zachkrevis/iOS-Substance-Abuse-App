//
//  Substance View.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/16/22.
//

import SwiftUI

struct SubstanceListView: View {
    
    @EnvironmentObject var manager : SubstanceManager
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateStarted)]) var substances : FetchedResults<Substance>
    
    @State var editToggle : Bool = false
    
    @State var toggleAlert: Bool = false
    
    @State var alertS : Substance?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("MenuColor").ignoresSafeArea()
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: newSubstance()) {
                                Image(systemName: "plus")
                            }
                            .padding()
                            .padding(.horizontal, 16)
                        }
                        List() {
                            ForEach(substances) { s in
                                Section {
                                    NavigationLink(destination: SubstanceView(s: s)) {
                                        ListRow(s: s, edit: editToggle)
                                            .padding()
                                    }
                                    .swipeActions(allowsFullSwipe: false) {
                                        Button(action: {
                                            alertS = s
                                            toggleAlert = true
                                        }, label: {
                                            Image(systemName: "minus.circle.fill")
                                        }).tint(Color.red)

                                    }
                                    .alert(isPresented: $toggleAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete \(s.name!)?"),
                                            message: Text("There is no undo"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                context.delete(s)
                                                try? context.save()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        Spacer()
                }
            }
        }
        .onAppear {
            UINavigationBar.appearance().barTintColor = .clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            
        }
    }
}

struct ListRow: View {
    @EnvironmentObject var manager : SubstanceManager
    let s : Substance
    let edit : Bool
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        GeometryReader { geometry in
                VStack {
                    VStack(alignment: .leading) {
                        Text(s.name ?? "No Name")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.vertical, 1)
                        
                        Group {
                            Text("Recovering for ") +
                            Text(String(Calendar.current.daysSince(s.dateStarted!)))
                                .foregroundColor(Color.accentColor) +
                            Text(" days.")
                        }
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .padding(.vertical, 1)
                        Group {
                            Text("Saved ") +
                            Text("\(manager.getSaved(s), specifier: "%.2f")").foregroundColor(Color.accentColor) +
                            Text(".")
                        }
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .padding(.vertical, 1)
                        
                    }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .foregroundColor(Color("TextColor"))
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
        }.frame(height: 124)
    }
}

struct SubstanceListView_Previews: PreviewProvider {
    static var previews: some View {
        SubstanceListView()
    }
}
