//
//  GalleryAnnotation.swift
//  MuseumApp
//
//  Created by Ito on 11/30/24.
//
import MapKit

struct GalleryAnnotation: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
    let markerType: MarkerType
}
enum MarkerType {
    case regular
    case start
    case waypoint
    case end
}

