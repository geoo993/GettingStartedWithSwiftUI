//
//  UserSettings.swift
//  Quidco Staging
//
//  Created by George Quentin Ngounou on 16/08/2020.
//  Copyright © 2020 Maple Syrup Media. All rights reserved.
//
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects

import SwiftUI

struct UserLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .font(.title)
            .cornerRadius(10)
    }
}

struct UserList: View {
    let users = (1...100).map { number in "User \(number)" }

    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    Text(user)
                        .modifier(UserLabel())
                    Text("Colored ")
                        .foregroundColor(.red)
                    +
                    Text("SwifUI ")
                        .foregroundColor(.green)
                    +
                    Text("Text")
                        .foregroundColor(.blue)
                }
            }.navigationBarTitle("Select a user")
        }
    }
}

class UserSettings: ObservableObject {
    @Published var score = 0
}

struct DetailView: View {
    @ObservedObject var settings = UserSettings()
    @State private var showingWelcome = false
    let user: String
    var body: some View {
        VStack {
            Toggle(isOn: $showingWelcome.animation(.spring())) {
                Text("See User")
            }

            if showingWelcome {
                Text("Detail for \(user) and the score is \(settings.score)")
                Button(action: {
                    self.settings.score += 1
                }) {
                    Text("Increase Score")
                }
            }
        }.padding(.all)
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}
