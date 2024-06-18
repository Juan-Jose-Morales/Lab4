//
//  MapView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 19/6/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let location: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView,context: Context){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            guard let placemarks = placemarks?.first, let location = placemarks.location else{
                if let error = error {
                    print("Geocoding failed with error: \(error.localizedDescription)")
                }
                return
            }
            let coordinate = location.coordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            //annotation.title = locationName(placemark: placemark)
            uiView.addAnnotation(annotation)
            uiView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        }
    }
    
    private func locationName(placemark: CLPlacemark) -> String {
        var name = ""
        if let city = placemark.locality {
            name += city
        }
        if let country = placemark.country {
            name += ",\(country)"
        }
        return name
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: "Madrid")
    }
}
