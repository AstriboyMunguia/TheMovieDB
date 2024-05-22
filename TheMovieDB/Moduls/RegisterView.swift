//
//  RegisterView.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 22/05/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // HEADER WITH LOGO AND TITLE
                    VStack {
                        Image("logovertical")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 200)
                            .padding(.top, 50) // Adjust the padding as needed
                        
                        Text("REGISTER")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10) // Adjust the padding as needed
                        
                        Text("Start to Watch Movies")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top, 0) // Adjust the padding as needed
                    }
                    
                    VStack(spacing: 20) {
                        
                        TextField("Full Name", text: $viewModel.name)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                        
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
                            title: "Create Account",
                            background: .white,
                            action: {
                                viewModel.register()
                            },
                            width: 300, // Specify width
                            height: 40 // Specify height
                        )
                        .padding()
                    }
                    .padding()
                }
                .offset(y: -50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    RegisterView()
}
