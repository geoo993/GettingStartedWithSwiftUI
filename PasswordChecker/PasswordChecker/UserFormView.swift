//
//  UserFormView.swift
//  OrigonHub
//
//  Created by GEORGE QUENTIN on 31/08/2020.
//  Copyright © 2020 GEORGE QUENTIN. All rights reserved.
//
// https://medium.com/flawless-app-stories/swiftui-plus-combine-equals-love-791ad444a082

import SwiftUI

struct UserFormView: View {
  
    @ObservedObject private var userViewModel = UserViewModel()
    @State var presentAlert = false

    var body: some View {
        Form {
          Section(footer: Text(userViewModel.usernameMessage).foregroundColor(.red)) {
            TextField("Username", text: $userViewModel.username)
              .autocapitalization(.none)
          }
          Section(footer: Text(userViewModel.passwordMessage).foregroundColor(.red)) {
            SecureField("Password", text: $userViewModel.password)
            SecureField("Password again", text: $userViewModel.passwordAgain)
          }
          Section {
            Button(action: { self.signUp() }) {
              Text("Sign up")
            }.disabled(!userViewModel.isValid)
          }
        }
        .sheet(isPresented: $presentAlert) {
            WelcomeView()
        }
    }

    func signUp() {
        self.presentAlert = true
    }

}

struct WelcomeView: View {
    var body: some View {
        Text("Welcome! Great to have you on board!")
    }
}

struct UserFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserFormView()
    }
}
