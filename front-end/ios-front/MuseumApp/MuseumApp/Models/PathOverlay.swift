//
//  PathOverlay.swift
//  MuseumApp
//
//  Created by Ito on 11/30/24.
//
import SwiftUI
import MapKit

struct PathOverlay: UIViewRepresentable {
    let coordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.isUserInteractionEnabled = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        uiView.addOverlay(polyline)
        
        if !coordinates.isEmpty {
            let rect = coordinates.reduce(MKMapRect.null) { rect, coordinate in
                let point = MKMapPoint(coordinate)
                let pointRect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)
                return rect.union(pointRect)
            }
            
            uiView.setVisibleMapRect(rect.insetBy(dx: -1000, dy: -1000), animated: true)
        }
    }
}
