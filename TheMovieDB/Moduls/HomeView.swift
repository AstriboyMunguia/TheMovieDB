//
//  HomeView.swift
//  TheMovieDB
//
//  Created by monscerrat gutierrez on 22/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var tabSeleccionado: Int = 2
    @StateObject var viewModelHome = HomeViewModel()
    
    var body: some View {
        
        TabView(selection: $tabSeleccionado) {
            
            GenderView()
                .tabItem {
                    Image(systemName: "movieclapper")
                    Text("Generos")
                }.tag(1)
            
            Home().tabItem {
                Image(systemName: "house")
                Text("Inicio")
                    .foregroundColor(.pink)
            }.tag(2)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(3)
        }
        .accentColor(.white)
    }
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color("TabBar-Color"))
        UITabBar.appearance().isTranslucent = true
    }
}

struct Home: View {
    @StateObject var viewModelHome = HomeViewModel()
    @State private var mostrarPerfil: Bool = false
    
    var body: some View {
        ZStack {
            // Fondo principal
            LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            mostrarPerfil.toggle()
                        }
                    }) {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.purple.opacity(0.6))
                            .font(.system(size: 35))
                            .padding(.horizontal, 30)
                    }
                }
                .padding(.trailing)
                
                Image("logoHorizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.vertical, -30)
                
                ScrollView(showsIndicators: false) {
                    FirstView(movies: viewModelHome.upcomingMovies ?? [], comedyMovies: viewModelHome.comedyMovies ?? [])
                    
                              
                }
            }
            
            // Botones en la parte posterior
            if mostrarPerfil {
                PerfilPopupView(cerrarPopup: {
                    withAnimation {
                        mostrarPerfil = false
                    }
                })
                .transition(.move(edge: .trailing))
                .zIndex(1) // Asegura que esté encima del contenido principal
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModelHome.getUpcomingMovies()
            viewModelHome.getcomedy()
        }
    }
}


struct PerfilPopupView: View {
    var cerrarPopup: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    cerrarPopup()
                }
            
            VStack {
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Button(action: {
                            // Acción para ir al perfil
                        }) {
                            Text("Perfil")
                                .font(.system(size: 30))
                                .foregroundColor(.purple)
                                .padding()
                        }
                        Spacer()
                        Divider()
                            .background(Color.white)
                        Button(action: {
                            // Acción para cerrar sesión
                        }) {
                            Text("Cerrar sesión")
                                .font(.system(size: 20))
                                .foregroundColor(.purple)
                                .padding()
                        }
                    }
                    .background(Color.black)
                    .frame(width: 200)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 50) // Ajusta esto según sea necesario
        }
    }
}

struct FirstView: View {
    var movies: [Movies]
    var comedyMovies: [Movies]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    HorizontalScrollView(title: "UPCOMING", color: .red, movies: movies)
                        .foregroundColor(.white)
                    HorizontalScrollView(title: "COMEDY", color: .red, movies: comedyMovies)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
        .padding()
    }
}

struct HorizontalScrollView: View {
    let title: String
    let color: Color
    var movies: [Movies]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(movies) { movie in
                        AsyncImage(url: URL(string: movie.primaryImage?.url ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
