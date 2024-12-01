//
//  ArtworkStore.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 11/26/24.
//

import Foundation

class ArtworkStore: ObservableObject {
    @Published var artworks: [Artwork] = [
        Artwork(
            id: 1,
            title: "One-dollar Liberty Head Coin",
            artist: "James Barton Longacre",
            location: "Gallery 774",
            description: "Historic American coin design",
            year: "1849"
        ),
        Artwork(
            id: 2,
            title: "Ten-dollar Liberty Head Coin",
            artist: "Christian Gobrecht",
            location: "Special Exhibition",
            description: "Rare numismatic specimen",
            year: "1838"
        ),
        Artwork(
            id: 3,
            title: "Ale Glass",
            artist: "New England Glass Company",
            location: "Gallery 774",
            description: "19th century glassware",
            year: "1850-1870"
        )
    ]
    
    // Function to fetch additional artwork details from API
    func fetchArtworkDetails(for artwork: Artwork) async throws -> [String: String?] {
        return try await ArtworkService.fetchArtworkDetails(imageID: artwork.id)
    }
}
