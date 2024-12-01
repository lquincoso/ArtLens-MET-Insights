//
//  NetworkManager.swift
//  MuseumApp
//
//  Created by Ito on 11/30/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    func updateRating(userArtwork: UserArtwork, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/ratings/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        do {
            let requestData = try encoder.encode(userArtwork)
            request.httpBody = requestData
        } catch {
            print("Failed to encode UserArtwork: \(error)")
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
}
