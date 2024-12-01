//
//  ArtworkAPI.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 12/1/24.
//

import Foundation

struct ArtworkAPI: Codable {
    let primaryImage: String
    let title: String
    let artistDisplayName: String
    let culture: String
    let objectBeginDate: Int
    
    enum CodingKeys: String, CodingKey {
        case primaryImage
        case title
        case artistDisplayName
        case culture
        case objectBeginDate
    }
}
