//
//  CustomButtonStyle.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 14/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

struct CustomButtonBackground<T: Shape>: View {
    @Environment(\.colorScheme) var colorScheme
    var isHighlighted: Bool
    var shape: T
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                if isHighlighted {
                    shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
                } else {
                    shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                }
            } else {
                if isHighlighted {
                    shape
                        .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(
                                    Circle().fill(LinearGradient(Color.black, Color.clear))
                            )
                    ).overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(
                                Circle().fill(LinearGradient(Color.clear, Color.black))
                        )
                    )
                } else {
                    shape
                        .fill(LinearGradient(Color.whiteStart, Color.whiteEnd))
                        .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 8, y: 8)
                        .shadow(color: Color.white.opacity(0.7), radius: 5, x: -5, y: -5)
                }
            }
        }
    }

}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .contentShape(Circle())
            .background(CustomButtonBackground(isHighlighted: configuration.isPressed, shape: Circle()))
            .animation(nil)
    }
}

struct CustomButtonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            configuration.label
                .padding(10)
                .contentShape(Circle())
        }
        .background(CustomButtonBackground(isHighlighted: configuration.isOn, shape: Circle()))
    }
}
