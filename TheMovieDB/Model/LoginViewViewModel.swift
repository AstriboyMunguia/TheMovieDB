//
//  LoginViewViewModel.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 22/05/24.
//

import Foundation
import SwiftUI

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var forgotPasswordEmail = ""
    @Published var forgotPasswordErrorMessage = ""
    @Published var isForgotPasswordSuccess = false
    @Published var name = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
    }
    
    func login() {
        guard validate() else {
            return
        }
        
        // TRY LOG IN
        // Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func forgotPassword() {
        guard validateForgotPassword() else {
            return
        }
        
        // TRY FORGOT PASSWORD
        // Auth.auth().sendPasswordReset(withEmail: forgotPasswordEmail) { [weak self] error in
        //     if let error = error {
        //         self?.forgotPasswordErrorMessage = error.localizedDescription
        //         self?.isForgotPasswordSuccess = false
        //     } else {
        //         self?.isForgotPasswordSuccess = true
        //     }
        // }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
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
