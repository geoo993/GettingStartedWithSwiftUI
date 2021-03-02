//
//  UserViewModel.swift
//  OrigonHub
//
//  Created by GEORGE QUENTIN on 31/08/2020.
//  Copyright © 2020 GEORGE QUENTIN. All rights reserved.
//
// https://medium.com/flawless-app-stories/swiftui-plus-combine-equals-love-791ad444a082

import Foundation
import Combine

class UserViewModel: ObservableObject {
    // input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""

    // output
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    @Published var isValid = false

    private var cancellableSet: Set<AnyCancellable> = []

    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
        .debounce(for: 0.8, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            return input.count >= 3
        }
        .eraseToAnyPublisher() // this performs some type erasure that makes sure we don't end up with some crazy nested return types.
    }

    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
        .debounce(for: 0.8, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { password in
            return password == ""
        }
        .eraseToAnyPublisher()
    }

    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
        .debounce(for: 0.2, scheduler: RunLoop.main)
        .map { password, passwordAgain in
            return password == passwordAgain
        }
        .eraseToAnyPublisher()
    }

    private var passwordStrengthPublisher: AnyPublisher<PasswordStrength, Never> {
        $password
        .debounce(for: 0.2, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { input in
            return PasswordValidation.strength(ofPassword: input)
        }
        .eraseToAnyPublisher()
    }

    private var isPasswordStrongEnoughPublisher: AnyPublisher<Bool, Never> {
        passwordStrengthPublisher
        .map { strength in
            print(PasswordValidation.localizedString(forStrength: strength))
            switch strength {
            case .reasonable, .strong, .veryStrong:
              return true
            default:
              return false
            }
        }
        .eraseToAnyPublisher()
    }

    enum PasswordCheck {
    case valid
    case empty
    case noMatch
    case notStrongEnough
    }

    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, arePasswordsEqualPublisher, isPasswordStrongEnoughPublisher)
        .map { passwordIsEmpty, passwordsAreEqual, passwordIsStrongEnough in
            if (passwordIsEmpty) {
              return .empty
            }
            else if (!passwordsAreEqual) {
              return .noMatch
            }
            else if (!passwordIsStrongEnough) {
              return .notStrongEnough
            }
            else {
              return .valid
            }
        }
        .eraseToAnyPublisher()
    
    }

    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
        .map { userNameIsValid, passwordIsValid in
            return userNameIsValid && (passwordIsValid == .valid)
        }
        .eraseToAnyPublisher()
    }

    init() {
        setupBindings()
    }
    
    func setupBindings() {
        
        isUsernameValidPublisher
            .receive(on: RunLoop.main) // As this code interfaces with the UI, it needs to run on the UI thread. We can tell SwiftUI to execute this code on the UI thread by calling receive(on: RunLoop.main).
            .map { $0 ? "" : "password__username_characters".localized }
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet) // We'll store this into a Set<AnyCancellable>, so we can clean up upon deinit.

        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                case .empty:
                    return "password__empty".localized
                case .noMatch:
                    return "password__no_match".localized
                case .notStrongEnough:
                    return "password__not_strong_enough".localized
                default:
                    return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet) // We'll store this into a Set<AnyCancellable>, so we can clean up upon deinit.

        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet) // We'll store this into a Set<AnyCancellable>, so we can clean up upon deinit.
        
    }

}
