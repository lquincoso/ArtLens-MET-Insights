//
//  ArtworkViewModel.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 12/1/24.
//

import SwiftUI

@MainActor
class ArtworkViewModel: ObservableObject {
    @Published var artworkDetails: [Int: [String: String?]] = [:]
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchArtworkDetails(for imageID: Int) async {
        if artworkDetails[imageID] != nil {
            return
        }
        
        isLoading = true
        do {
            let details = try await ArtworkService.fetchArtworkDetails(imageID: imageID)
            artworkDetails[imageID] = details
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
