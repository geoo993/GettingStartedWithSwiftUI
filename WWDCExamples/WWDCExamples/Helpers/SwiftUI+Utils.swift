//
//  SwiftUI+Utils.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 14/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

extension String {
    
    var uppercaseFirst: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

extension Color {
    static let whiteStart = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let whiteEnd = Color(red: 205 / 255, green: 205 / 255, blue: 225 / 255)
    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
