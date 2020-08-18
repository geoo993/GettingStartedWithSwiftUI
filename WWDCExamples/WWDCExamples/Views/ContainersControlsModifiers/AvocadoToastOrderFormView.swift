//
//  AvocadoToastView.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 03/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

struct AvocadoToastView: View {
    let orders: [MealOrder]
    
    var body: some View {
        NavigationView {
            TabView {
                OrderForm(order: orders[0])
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("New Order")
                }
                AvocadoToastOrderHistoryView(previousOrders: orders)
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("History")
                }
            }
        }
    }
}

struct AvocadoToastView_Previews: PreviewProvider {
    static var previews: some View {
        AvocadoToastView(orders: mockOrdersData)
    }
}

// MARK: - OrderForm

struct OrderForm: View {
    @State var order: MealOrder
    @State var connectedToToastNetwork: Bool = true
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $order.includeCheese) {
                    Text("Include Cheese")
                }
                Toggle(isOn: $order.includeRedPepper) {
                    Text("Include Red Pepper")
                }
                Toggle(isOn: $order.includePepperoni) {
                    Text("Include Pepperoni")
                }
                Toggle(isOn: $order.includeEggs) {
                    Text("Include Egg")
                }
            }
            Section {
                Picker(selection: $order.drink, label: Text("Drink")) {
                    ForEach(Drink.allCases) { drink in
                        Text(drink.name).tag(drink)
                    }
                }
            }
            Section {
                Stepper(value: $order.quantity, in: 1...10) {
                    Text("Quality: \(order.quantity)")
                }
            }
            Section {
                Button(action: submitOrder) {
                    Text("Order")
                }.disabled(order.quantity == 0)
            }
        }
        .accentColor(Color.green)
        .disabled(!connectedToToastNetwork)
        //.padding(.horizontal)
        //.opacity(0.5)
        .navigationBarTitle(Text("Avocado Toast"))
    }
    
    func submitOrder() {
        
    }
}
