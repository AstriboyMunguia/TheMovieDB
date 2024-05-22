//
//  LoginView.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 21/05/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // HEADER WITH LOGO
                    VStack {
                        Image("logovertical") // Use the name of your image asset here
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200) // Adjust the size as needed
                            .padding(.top, 5) // Adjust the padding as needed
                    }
                    .padding(.bottom, 50)
                    
                    // LOGIN FORM
                    VStack(spacing: 20) {
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(Color.red)
                        }
                        
                        TextField("Email Address", text: $viewModel.email)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                        
                        TLButton(
                            title: "Log In",
                            background: .white,
                            action: {
                                viewModel.login()
                            },
                            width: 300, // Specify width
                            height: 40 // Specify height
                        )
                        .padding()
                        
                        NavigationLink("Forgot Password?", destination: ForgotPasswordView(viewModel: viewModel))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white.opacity(0.0))
                    .cornerRadius(10)
                    .offset(y: -50)
                    
                    // CREATE ACCOUNT
                    VStack {
                        Text("New around here?")
                            .foregroundColor(.white)
                        
                        NavigationLink("Create An Account", destination: RegisterView())
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
