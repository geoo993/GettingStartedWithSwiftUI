//
//  StateExample.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 17/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

// SwiftUI uses the @State property wrapper to allow us to modify values inside a struct, which would normally not be allowed because structs are value types.

struct StateExample: View {
    var username: String = "Alex"
    @State var isEnabled: Bool = false
    
    var body: some View {
        HStack {
            Text("Hello, my name is \(username)")
                .foregroundColor(isEnabled ? Color.primary : Color.secondary)
                .layoutPriority(1)
            DetailedStateExample(isEnabled: $isEnabled)
        }.padding(.all)
    }
}

struct DetailedStateExample: View {
    @Binding var isEnabled: Bool
    
    var body: some View {
        Toggle(isOn: $isEnabled) {
            EmptyView()
        }
    }
}

struct StateExample_Previews: PreviewProvider {
    static var previews: some View {
        StateExample()
    }
}
