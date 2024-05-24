//
//  GenerView.swift
//  TheMovieDB
//
//  Created by monscerrat gutierrez on 22/05/24.
//

import SwiftUI

struct GenderView: View {
    
    @StateObject var viewModel = GenerViewModel()

    // Example data for the bubbles
    let bubbleTexts = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty", "twenty one", "twenty two", "twenty three", "twenty four", "twenty five", "twenty six", "twenty seven", "twenty eight"]

    // Grid layout with three columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Header Text
                    Text("GENDERS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40) // Adjust padding as needed
                        .padding(.bottom, 20) // Adjust spacing below header
                    
                    // Bubbles in Grid
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(bubbleTexts, id: \.self) { text in
                                AnimatedBubbleView(text: text)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct AnimatedBubbleView: View {
    let text: String
    
    @State private var floatUp = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.pink.opacity(0.2))
                .frame(width: 100, height: 100) // Adjust size as needed
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                        .shadow(color: Color.white.opacity(0.5), radius: 10)
                )
            Text(text)
                .foregroundColor(.white)
                .bold()
        }
        .offset(y: floatUp ? -10 : 10)
        .onAppear {
            let baseAnimation = Animation.easeInOut(duration: Double.random(in: 2...4))
            withAnimation(baseAnimation.repeatForever(autoreverses: true)) {
                floatUp.toggle()
            }
        }
        .animation(Animation.easeInOut(duration: Double.random(in: 2...4))
            .repeatForever(autoreverses: true), value: floatUp)
    }
}

#Preview {
    GenderView()
}
