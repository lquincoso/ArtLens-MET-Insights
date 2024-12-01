//
//  ArtworkService.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 12/1/24.
//

import Foundation

class ArtworkService {
    static func fetchArtworkDetails(imageID: Int) async throws -> [String: String?] {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(imageID)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let artwork = try JSONDecoder().decode(ArtworkAPI.self, from: data)
        
        return [
            "imageUrl": artwork.primaryImage,
            "title": artwork.title,
            "artist": artwork.artistDisplayName,
            "culture": artwork.culture,
            "year": String(artwork.objectBeginDate)
        ]
    }
}
