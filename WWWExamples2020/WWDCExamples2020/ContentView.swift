//
//  ContentView.swift
//  WWWExamples2020
//
//  Created by GEORGE QUENTIN on 25/10/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: SandwichStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.sandwiches) { item in
                    SandwicheCell(sandwich: item)
                }
                .onMove(perform: moveSandwiches)
                .onDelete(perform: deleteSandwishes)
                
                HStack {
                    Spacer()
                    Text("\(store.sandwiches.count) Sandwiches")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Sandwishes")
            .toolbar {
                #if os(iOS)
                    EditButton()
                #endif
            }.navigationBarItems(leading:
                Button("Add", action: makeSandwiches)
            )
            
            // Placeholder View for iPad
            Text("Select a Sandwich")
                .font(.largeTitle)
        }
    }
    
    func makeSandwiches() {
        withAnimation {
            store.sandwiches.append(Sandwich(name: "Bred Butter", ingredientCount: 3, isSpicy: true))
        }
    }
    
    func moveSandwiches(from: IndexSet, to: Int) {
        withAnimation {
            store.sandwiches.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func deleteSandwishes(offset: IndexSet) {
        withAnimation {
            store.sandwiches.remove(atOffsets: offset)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: testStore)
    }
}

struct SandwicheCell: View {
    var sandwich: Sandwich
    var body: some View {
        NavigationLink(destination: SandwichDetail(sandwich: sandwich)) {
            HStack {
                Image(sandwich.thumbnailName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(12.0)
                    .aspectRatio(contentMode: .fill)
                
                VStack(alignment: .leading) {
                    Text(sandwich.name)
                    Text("\(sandwich.ingredientCount) indgredients")
                        .font(.subheadline)
                        .foregroundColor(Color.green)
                }
            }
        }
    }
}
