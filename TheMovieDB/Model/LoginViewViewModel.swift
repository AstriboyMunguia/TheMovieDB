//
//  LoginViewViewModel.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 22/05/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var forgotPasswordEmail = ""
    @Published var forgotPasswordErrorMessage = ""
    @Published var isForgotPasswordSuccess = false
    @Published var name = ""

    init() {}

    // Register function
    func register() {
        guard validate() else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }

            guard let userId = result?.user.uid else {
                self?.errorMessage = "Failed to retrieve user ID."
                return
            }

            self?.insertUserRecord(id: userId)
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users").document(id).setData(newUser.asDictionary()) { error in
            if let error = error {
                self.errorMessage = "Failed to insert user record: \(error.localizedDescription)"
            }
        }
    }

    func login() {
        guard validate() else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }

            self.errorMessage = ""
        }
    }

    func forgotPassword() {
        guard validateForgotPassword() else {
            return
        }

        Auth.auth().sendPasswordReset(withEmail: forgotPasswordEmail) { [weak self] error in
            if let error = error {
                self?.forgotPasswordErrorMessage = error.localizedDescription
                self?.isForgotPasswordSuccess = false
            } else {
                self?.isForgotPasswordSuccess = true
            }
        }
    }

    private func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return false
        }

        return true
    }

    private func validateForgotPassword() -> Bool {
        forgotPasswordErrorMessage = ""
        guard !forgotPasswordEmail.trimmingCharacters(in: .whitespaces).isEmpty else {
            forgotPasswordErrorMessage = "Please enter your email address."
            return false
        }

        guard forgotPasswordEmail.contains("@") && forgotPasswordEmail.contains(".") else {
            forgotPasswordErrorMessage = "Please enter a valid email address."
            return false
        }

        return true
    }
}
