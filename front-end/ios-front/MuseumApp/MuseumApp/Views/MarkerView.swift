//
//  MarkerView.swift
//  MuseumApp
//
//  Created by Ito on 11/30/24.
//
import SwiftUI

struct MarkerView: View {
    let type: MarkerType
    let galleryId: String
    let galleryName: String
    @State private var showingDetails = false
    
    var body: some View {
        Button {
            showingDetails.toggle()
        } label: {
            Image(systemName: markerImage)
                .font(.title2)
                .foregroundColor(markerColor)
                .padding(8)
                .background(Circle().fill(.white))
                .shadow(radius: 2)
        }
        .popover(isPresented: $showingDetails) {
            VStack(alignment: .leading, spacing: 8) {
                Text(galleryName)
                    .font(MetFonts.body.bold())
                Text("Gallery \(galleryId)")
                    .font(MetFonts.body)
                    .foregroundColor(MetColors.textSecondary)
            }
            .padding()
        }
    }
    
    private var markerImage: String {
        switch type {
        case .regular: return "mappin"
        case .start: return "figure.walk.circle.fill"
        case .waypoint: return "circle.fill"
        case .end: return "flag.circle.fill"
        }
    }
    
    private var markerColor: Color {
        switch type {
        case .regular: return .gray
        case .start: return .green
        case .waypoint: return .blue
        case .end: return .red
        }
    }
}
