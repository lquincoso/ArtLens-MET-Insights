//
//  CustomMapView.swift
//  MuseumApp
//
//  Created by Ito on 11/30/24.
//
import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let annotations: [GalleryAnnotation]
    let pathCoordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
        
        // Remove existing annotations and overlays
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        // Add markers
        annotations.forEach { annotation in
            let marker = CustomAnnotation(
                coordinate: annotation.coordinate,
                title: annotation.id,
                markerType: annotation.markerType
            )
            mapView.addAnnotation(marker)
        }
        
        // Add path if we have coordinates
        if pathCoordinates.count >= 2 {
            let polyline = MKPolyline(coordinates: pathCoordinates, count: pathCoordinates.count)
            mapView.addOverlay(polyline)
            
            // Adjust region to show the entire path
            let rect = polyline.boundingMapRect
            mapView.setVisibleMapRect(rect.insetBy(dx: -1000, dy: -1000), animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CustomMapView
        
        init(_ parent: CustomMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let customAnnotation = annotation as? CustomAnnotation else { return nil }
            
            let identifier = "GalleryMarker"
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            switch customAnnotation.markerType {
            case .start:
                annotationView.markerTintColor = .systemGreen
                annotationView.glyphImage = UIImage(systemName: "figure.walk")
            case .end:
                annotationView.markerTintColor = .systemRed
                annotationView.glyphImage = UIImage(systemName: "flag.fill")
            case .waypoint:
                annotationView.markerTintColor = .systemBlue
                annotationView.glyphImage = UIImage(systemName: "circle.fill")
            case .regular:
                annotationView.markerTintColor = .systemGray
                annotationView.glyphImage = UIImage(systemName: "mappin")
            }
            
            return annotationView
        }
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let markerType: MarkerType
    
    init(coordinate: CLLocationCoordinate2D, title: String?, markerType: MarkerType) {
        self.coordinate = coordinate
        self.title = title
        self.markerType = markerType
        super.init()
    }
}
