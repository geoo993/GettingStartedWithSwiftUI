//
//  IconOrientationEditor.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 11/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

struct IconOrientationEditor: View {
    let flipped: Bool
    
    var body: some View {
        ZStack {
            Color.gray
            AppIcon()
                .rotationEffect(.degrees(flipped ? 180 : 0))
        }
    }
}

struct IconOrientationEditor_Previews: PreviewProvider {
    static var previews: some View {
        IconOrientationEditor(flipped: true)
    }
}

// MARK: - AppIcon

struct AppIcon: View {
    var body: some View {
        Image("avocado-skipping")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 320.0, height: 320.0, alignment: .top)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.orange, lineWidth: 5))
    }
}
