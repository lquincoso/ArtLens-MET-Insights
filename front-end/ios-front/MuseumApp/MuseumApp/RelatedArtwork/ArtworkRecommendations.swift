import SwiftUI

struct ArtworkRecommendations: View {
    @State private var artworks: [(imageTitle: String?, imageData: Data?)] = []
    let desiredArtwork: String

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    if artworks.isEmpty {
                        ProgressView("Loading Related Artworks...")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(artworks.indices, id: \.self) { index in
                            let artwork = artworks[index]
                            if let imageData = artwork.imageData, let uiImage = UIImage(data: imageData) {
                                VStack {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                        .cornerRadius(12)
                                        .shadow(radius: 5)
                                        .scaleEffect(1.1)
                                        .animation(.easeInOut(duration: 0.3), value: imageData)
                                        .onTapGesture {
                                            //Navigate to Artwork detail
                                        }
                                    
                                    if let title = artwork.imageTitle {
                                        Text(title)
                                            .font(.headline)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 5)
                                    } else {
                                        Text("Title Unavailable")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                            .padding(.top, 5)
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: .black.opacity(0.1), radius: 5)
                                )
                                .padding(5)
                                .transition(.scale)
                            }
                        }
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Related Artworks")
                        .font(MetFonts.titleLarge)
                }
            }
            .onAppear {
                Task {
                    do {
                        let similarArtworks = try await RelatedArtworks.fetchRelatedArt(artworkId: desiredArtwork)
                        
                        for id in similarArtworks {
                            fetchImageData(imageID: id)
                        }
                    } catch {
                        print("Error fetching related artworks: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func fetchImageData(imageID: Int) {
        FetchArtwork.getImageData(imageID: imageID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageDetails):
                    guard let urlString = imageDetails["imageUrl"],
                          let title = imageDetails["title"],
                          let url = URL(string: urlString!) else {
                        print("Invalid image details for ID: \(imageID)")
                        return
                    }
                    
                    fetchImage(from: url) { data in
                        if let data = data {
                            DispatchQueue.main.async {
                                withAnimation {
                                    artworks.append((imageTitle: title, imageData: data))
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("Error fetching image data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
}

#Preview {
    ArtworkRecommendations(desiredArtwork: "9854")
}
