//
//  SplashView.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 21/05/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            LoginView()
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("logovertical") // Usa el nombre de tu imagen aquí
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200) // Ajusta el tamaño según sea necesario
                        .padding(.top, 05) // Ajusta el padding según sea necesario
//                    Text("Bienvenido a mi App")
//                        .font(.title)
//                        .foregroundColor(.white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
