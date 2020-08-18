//
//  CustomBackgroundView.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 14/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

struct CustomCircularBackground: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        if colorScheme == .dark {
            return Circle()
                .fill(LinearGradient(Color.darkEnd, Color.darkStart))
        } else {
            return Circle()
                .fill(LinearGradient(Color.whiteEnd, Color.whiteStart))
        }
    }
}
