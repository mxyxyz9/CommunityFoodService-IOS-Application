import SwiftUI
import MapKit

struct DraggableMapView: UIViewRepresentable {
    @Binding var coordinate: CLLocationCoordinate2D
    @Binding var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        
        // Add a pin annotation at the initial coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map region
        uiView.setRegion(region, animated: true)
        
        // If we already have an annotation, update its coordinate; otherwise, add one
        if let annotation = uiView.annotations.first as? MKPointAnnotation {
            annotation.coordinate = coordinate
        } else {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: DraggableMapView

        init(_ parent: DraggableMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Don’t customize the user location (blue dot).
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "DraggablePin"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            if view == nil {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.isDraggable = true
                view?.canShowCallout = true
            } else {
                view?.annotation = annotation
            }
            return view
        }
        
        func mapView(_ mapView: MKMapView,
                     annotationView view: MKAnnotationView,
                     didChange newState: MKAnnotationView.DragState,
                     fromOldState oldState: MKAnnotationView.DragState) {
            if newState == .ending || newState == .canceling {
                if let annotation = view.annotation as? MKPointAnnotation {
                    // Update the SwiftUI binding with the new coordinate
                    DispatchQueue.main.async {
                        self.parent.coordinate = annotation.coordinate
                    }
                }
                view.setDragState(.none, animated: true)
            }
        }
    }
}
