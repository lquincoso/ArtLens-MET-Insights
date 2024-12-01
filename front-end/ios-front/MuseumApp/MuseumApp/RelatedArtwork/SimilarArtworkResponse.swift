//
//  RelatedArtworkResponse.swift
//  MuseumApp
//
//  Created by Ito on 11/29/24.
//
struct SimilarArtworksResponse: Decodable {
    let similarArtworks: [Int]
    
    enum CodingKeys: String, CodingKey {
        case similarArtworks = "similar_artworks"
    }
}
