//
//  ArtworkDetailView.swift
//  MuseumApp
//
//  Created by Mauricio Piedra on 12/1/24.
//

import SwiftUI

struct ArtworkDetailView: View {
    let artworkId: Int
    @State private var imageDetails: [String: String?]?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            if let details = imageDetails {
                VStack(alignment: .leading, spacing: 12) {
                    if let urlString = details["imageUrl"],
                       let url = URL(string: urlString ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 300, maxHeight: 300)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.top, 10)
                    }
                    
                    Text("Title: \(details["title"] ?? "Unknown Title")")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("Artist: \(details["artist"] ?? "Unknown Artist")")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    
                    Text("Culture: \(details["culture"] ?? "Unknown Culture")")
                        .font(.body)
                        .padding(.bottom, 5)
                    
                    Text("Year: \(details["year"] ?? "Unknown Year")")
                        .font(.body)
                        .padding(.bottom, 5)
                }
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ProgressView("Loading artwork details...")
                    .padding()
            }
        }
        .padding()
        .onAppear {
            fetchArtworkDetails()
        }
    }
    
    private func fetchArtworkDetails() {
        FetchArtwork.getImageData(imageID: artworkId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedDetails):
                    self.imageDetails = fetchedDetails
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
