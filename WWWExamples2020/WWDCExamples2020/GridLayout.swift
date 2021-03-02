//
//  GridLayout.swift
//  WWDCExamples2020
//
//  Created by GEORGE QUENTIN on 25/10/2020.
//

import SwiftUI

struct CustomItem: Identifiable {
    var id = UUID()
    let name: String
}

let itemsDate: [CustomItem] = [
    CustomItem(name: "A"),
    CustomItem(name: "B"),
    CustomItem(name: "C"),
    CustomItem(name: "D"),
    CustomItem(name: "E"),
    CustomItem(name: "F"),
    CustomItem(name: "G"),
    CustomItem(name: "H"),
    CustomItem(name: "I"),
    CustomItem(name: "J"),
    CustomItem(name: "K"),
    CustomItem(name: "L"),
    CustomItem(name: "M"),
    CustomItem(name: "N"),
    CustomItem(name: "O"),
    CustomItem(name: "P"),
    CustomItem(name: "Q"),
    CustomItem(name: "R"),
    CustomItem(name: "S"),
    CustomItem(name: "T"),
    CustomItem(name: "U"),
    CustomItem(name: "V"),
    CustomItem(name: "W"),
    CustomItem(name: "X"),
    CustomItem(name: "Y"),
    CustomItem(name: "Z")
]

struct GridLayout: View {
    let items: [CustomItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
            //LazyVGrid(columns: [GridItem(.fixed(20))]) {
                ForEach(items) { item in
                    Text(item.name)
                }
            }
        }
    }
}

struct GridLayout_Previews: PreviewProvider {
    static var previews: some View {
        GridLayout(items: itemsDate)
    }
}
