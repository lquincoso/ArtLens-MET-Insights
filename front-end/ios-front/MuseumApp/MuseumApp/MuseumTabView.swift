//
//  MuseumTabView.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 11/21/24.
//

import SwiftUI

struct MuseumTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(1)
            
            ArtworkDetailView(artworkId: 985) // Example artwork ID
                .tabItem {
                    Label("Featured", systemImage: "star.fill")
                }
                .tag(1)
            
            CollectionsView()
                .tabItem {
                    Label("Collections", systemImage: "square.grid.2x2")
                }
                .tag(2)
            
            ToursView()
                .tabItem {
                    Label("Tours", systemImage: "map")
                }
                .tag(3)
        }
    }
}
