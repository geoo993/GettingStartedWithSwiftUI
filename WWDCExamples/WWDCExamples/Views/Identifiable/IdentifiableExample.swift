//
//  IdentifiableExample.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 17/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

// When we create static views in SwiftUI, SwiftUI knowns exactly which views we have, and is able to control them, animate them, and more. But when we use List or ForEach to make dynamic views, SwiftUI needs to know how it can identify each item uniquely otherwise it’s not able to compare view hierarchies to figure out what has changed.

struct StaticListExample: View {
    var body: some View {
        List {
            Text("Banana").foregroundColor(.yellow)
            Text("Apple").foregroundColor(.green)
            Text("Pear").foregroundColor(.green)
            Text("Orange").foregroundColor(.orange)
            Text("Pineaple").foregroundColor(.yellow)
            Text("Blueberry").foregroundColor(.blue)
            Text("Avocado").foregroundColor(.green)
            Text("Grapes").foregroundColor(.green)
            Text("Strawberry").foregroundColor(.red)
            Text("Watermelon").foregroundColor(.green)
        }
    }
}

struct Fruit: Identifiable {
    var id = UUID()
    let name: String
    let color: Color
}

struct IdentifiableExample: View {
    let fruits = [
        Fruit(name: "Banana", color: .yellow),
        Fruit(name: "Apple", color: .green),
        Fruit(name: "Pear", color: .green),
        Fruit(name: "Orange", color: .orange),
        Fruit(name: "Pineaple", color: .yellow),
        Fruit(name: "Blueberry", color: .blue),
        Fruit(name: "Avocado", color: .green),
        Fruit(name: "Grapes", color: .green),
        Fruit(name: "Strawberry", color: .red),
        Fruit(name: "Watermelon", color: .green)
    ]
    var body: some View {
        // Here, we are letting our List know to use our name to idendify each fruit
//        List(fruits, id: \.name) { fruit in
//            HStack {
//                Text(fruit.name).foregroundColor(fruit.color)
//            }
//        }
        
        // This is another way of letting our List know how to identify each row as unique because its using to UUID specified with the Identifiable protocol
        List(fruits) { fruit in
            HStack {
                Text(fruit.name).foregroundColor(fruit.color)
            }
        }
        
        // Same with ForEach
//        VStack {
//            ForEach(fruits, id: \.name) { fruit in
//                Text(fruit.name).foregroundColor(fruit.color)
//            }
//        }
    }
}

struct IdentifiableExample_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StaticListExample()
                .environment(\.colorScheme, .dark)
            IdentifiableExample()
        }
    }
}
