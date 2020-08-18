//
//  ObservedObjectExample.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 17/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//

import SwiftUI

// ObservableObject protocol is used with some sort of class that can store data, the @ObservedObject property wrapper is used inside a view to store an observable object instance, and the @Published property wrapper is added to any properties inside an observed object that should cause views to update when they change.

class ObservedObjectModel: ObservableObject {
    var username: String = "Alex"
    @Published var isEnabled: Bool = false
}

struct ObservedObjectExample: View {
    @ObservedObject var viewModel = ObservedObjectModel()
  
    var body: some View {
        HStack {
            Text("Hello, my name is \(viewModel.username)")
                .foregroundColor(viewModel.isEnabled ? Color.primary : Color.secondary)
                .layoutPriority(1)
            DetailedObservedObjectExample(isEnabled: $viewModel.isEnabled)
        }.padding(.all)
    }
}

struct DetailedObservedObjectExample: View {
    @Binding var isEnabled: Bool
    
    var body: some View {
        Toggle(isOn: $isEnabled) {
            EmptyView()
        }
    }
}

struct ObservedObjectExample_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjectExample()
    }
}
