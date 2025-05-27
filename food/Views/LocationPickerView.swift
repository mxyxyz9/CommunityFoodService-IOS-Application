import SwiftUI
import MapKit
import CoreLocation

// We'll use a custom comparison function instead of conforming to Equatable
func areCoordinatesEqual(_ lhs: CLLocationCoordinate2D, _ rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}

struct LocationPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedLocation: Location?
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var pinCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    @State private var addressText: String = ""
    @State private var errorMessage: String = ""
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            DraggableMapView(coordinate: $pinCoordinate, region: $region)
                .edgesIgnoringSafeArea(.all)
                .onChange(of: pinCoordinate.latitude) { _, _ in
                    reverseGeocodeCoordinate(coordinate: pinCoordinate)
                }
                .onChange(of: pinCoordinate.longitude) { _, _ in
                    reverseGeocodeCoordinate(coordinate: pinCoordinate)
                }
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    Rectangle()
                        .frame(width: 40, height: 4)
                        .cornerRadius(2)
                        .foregroundColor(.secondary)
                        .opacity(0.5)
                        .padding(.top, 8)
                    
                    TextField("Enter address", text: $addressText, onCommit: {
                        geocodeAddress()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)
                    .padding(.horizontal, 16)
                    
                    Button {
                        if let currentLocation = locationManager.lastLocation {
                            let currentCoordinate = currentLocation.coordinate
                            pinCoordinate = currentCoordinate
                            region.center = currentCoordinate
                            reverseGeocodeCoordinate(coordinate: currentCoordinate)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "location.fill")
                            Text("Use My Current Location")
                        }
                        .font(.callout)
                    }
                    .padding(.horizontal, 16)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal, 16)
                    }
                    
                    Button {
                        let finalAddress = addressText.isEmpty ? "Selected Location" : addressText
                        selectedLocation = Location(
                            latitude: pinCoordinate.latitude,
                            longitude: pinCoordinate.longitude,
                            address: finalAddress
                        )
                        dismiss()
                    } label: {
                        Text("Confirm Location")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
    
    private func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressText) { placemarks, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            if let coordinate = placemarks?.first?.location?.coordinate {
                pinCoordinate = coordinate
                region.center = coordinate
            } else {
                errorMessage = "Location not found."
            }
        }
    }
    
    private func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, error in
            if let placemark = placemarks?.first {
                addressText = [placemark.name, placemark.locality, placemark.administrativeArea]
                    .compactMap({ $0 })
                    .joined(separator: ", ")
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.first
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}
