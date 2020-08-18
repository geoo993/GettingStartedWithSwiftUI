//
//  AvocadoToastOrderHistoryView.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 03/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

struct AvocadoToastOrderHistoryView: View {
    let previousOrders: [MealOrder]
    
    var body: some View {
        List(previousOrders) { order in
            NavigationLink(destination: OrderDetail()) {
                HStack {
                    OrderCell(order: order)
                }
            }
        }
    }
}

struct AvocadoToastOrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        AvocadoToastOrderHistoryView(previousOrders: mockOrdersData)
    }
}

// MARK: - Order Cell

struct OrderCell: View {
    @State var order: MealOrder
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.summary)
                    .font(.headline)
                Text(order.purchaseDate)
                    .font(.subheadline)
                    .foregroundColor(Color.green)
            }
            Spacer()
            ForEach(order.toppings, content: { (toppin) in
                ToppingIcon(toppin: toppin)
            })

        }
    }
    
}

// MARK: - Order Cell

struct OrderDetail: View {

    var body: some View {
        Text("Hello World")
    }
    
}

// MARK: - ToppingIcon

struct ToppingIcon: View {
    let toppin: Topping
    
    var body: some View {
        switch toppin {
        case .cheese:
            return AnyView(CheeseIcon())
        case .eggs:
            return AnyView(EggSlate())
        case .pepperoni:
            return AnyView(PepperoniChunk())
        case .redPepper:
            return AnyView(RedPepperFlakes())
        }
    }
}

// MARK: - CheeseIcon

struct CheeseIcon: View {
    
    var body: some View {
        Circle().background(Color.blue)
    }
}

// MARK: - RedPepper

struct RedPepperFlakes: View {
    
    var body: some View {
        Circle().background(Color.green)
    }
}

// MARK: - PepperoniChunk

struct PepperoniChunk: View {
    
    var body: some View {
        Circle().background(Color.red)
    }
}

// MARK: - Egg

struct EggSlate: View {
    
    var body: some View {
        Circle().background(Color.yellow)
    }
}
