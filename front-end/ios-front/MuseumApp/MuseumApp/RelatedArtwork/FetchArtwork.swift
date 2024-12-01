//
//  FetchArtwork.swift
//  MuseumApp
//
//  Created by Ito on 11/29/24.
//
import SwiftUI

struct FetchArtwork {
    static func getImageData(imageID: Int, completion: @escaping (Result<[String: String?], Error>) -> Void) {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(imageID)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: [NSLocalizedDescriptionKey: "The URL is invalid."])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data received."])))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ArtworkAPI.self, from: data)
                let imageDetails: [String: String?] = [
                    "imageUrl": decodedData.primaryImage,
                    "title": decodedData.title,
                    "artist": decodedData.artistDisplayName,
                    "culture": decodedData.culture,
                    "year": String(decodedData.objectBeginDate)
                ]
                completion(.success(imageDetails))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
