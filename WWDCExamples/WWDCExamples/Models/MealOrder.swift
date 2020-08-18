//
//  MealOrder.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 03/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import Foundation

// MARK: - Toppings

enum Topping: CaseIterable, Hashable, Identifiable {
    case cheese
    case eggs
    case redPepper
    case pepperoni
}

extension Topping {
    
    var id: UUID {
        return UUID()
    }
}

// MARK: - Drink

enum Drink: CaseIterable, Hashable, Identifiable {
    case none
    case coke
    case sprite
    case fanta
    case orange
    case water
}

extension Drink {
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        return String(describing: self).uppercaseFirst
    }
}

// MARK: - MealOrder

struct MealOrder: Identifiable {
    var id = UUID()
    let summary: String
    var toppings: [Topping]
    var drink = Drink.none
    var notes: String = ""
    var includeCheese: Bool = false {
        didSet {
            if includeCheese {
                toppings.append(.cheese)
            } else {
                toppings.removeAll(where: { $0 == .cheese })
            }
        }
    }
    var includeRedPepper: Bool = false {
        didSet {
            if includeRedPepper {
                toppings.append(.redPepper)
            } else {
                toppings.removeAll(where: { $0 == .redPepper })
            }
        }
    }
    var includePepperoni: Bool = false {
        didSet {
            if includePepperoni {
                toppings.append(.pepperoni)
            } else {
                toppings.removeAll(where: { $0 == .pepperoni })
            }
        }
    }
    var includeEggs: Bool = false {
        didSet {
            if includePepperoni {
                toppings.append(.eggs)
            } else {
                toppings.removeAll(where: { $0 == .eggs })
            }
        }
    }
    var purchaseDate = Date().description
    var quantity: Int = 1
    init(summary: String, toppings: Topping...) {
        self.summary = summary
        self.toppings = toppings
    }
}

let mockOrdersData: [MealOrder] = [
    MealOrder(summary: "My MacD Pizza", toppings: .cheese, .redPepper, .pepperoni),
    MealOrder(summary: "Best Pep Pizza in the House", toppings: .cheese),
    MealOrder(summary: "MaD Pepperoni", toppings: .cheese, .redPepper),
    MealOrder(summary: "Festive Pep Pizza on the GO", toppings: .pepperoni),
    MealOrder(summary: "Birthday Pizza", toppings: .cheese, .eggs, .pepperoni)
]
