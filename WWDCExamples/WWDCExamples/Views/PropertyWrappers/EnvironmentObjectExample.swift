//
//  EnvironmentObjectExample.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 17/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

// For data that should be shared with all views in your entire app, SwiftUI gives us @EnvironmentObject. This lets us share model data anywhere it’s needed, while also ensuring that our views automatically stay updated when that data changes.

// Think of @EnvironmentObject as a smarter, simpler way of using @ObservedObject on lots of views.
class EnvironmentObjectModel: ObservableObject {
    var username: String = "Alex"
    @Published var isEnabled: Bool = false
}

struct EnvironmentObjectExample: View {
    @EnvironmentObject var viewModel: EnvironmentObjectModel
  
    var body: some View {
        HStack {
            Text("Hello, my name is \(viewModel.username)")
                .foregroundColor(viewModel.isEnabled ? Color.primary : Color.secondary)
                .layoutPriority(1)
            DetailedEnvironmentObjectExample()
        }.padding(.all)
    }
}

struct DetailedEnvironmentObjectExample: View {
    @EnvironmentObject var viewModel: EnvironmentObjectModel
    
    var body: some View {
        Toggle(isOn: $viewModel.isEnabled) {
            EmptyView()
        }
    }
}

struct EnvironmentObjectExample_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectExample().environmentObject(
            EnvironmentObjectModel()
        )
    }
}
