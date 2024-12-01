//
//  RelatedArtworks.swift
//  MuseumApp
//
//  Created by Ito on 11/29/24.
//
import Foundation

struct RelatedArtworks {
    
    static func fetchRelatedArt(artworkId: String) async throws -> [Int] {
        guard let url = URL(string: "http://127.0.0.1:5000/recommend") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(["artwork_id": artworkId])
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch similar artworks"])
            }
            
            let decodedResponse = try JSONDecoder().decode(SimilarArtworksResponse.self, from: data)
            print(decodedResponse.similarArtworks)
            return decodedResponse.similarArtworks
        } catch {
            print("Failed to fetch artworks: \(error)")
            throw error
        }
    }

}
