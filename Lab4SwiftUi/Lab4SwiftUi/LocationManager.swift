//
//  LocationManager.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 12/6/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentLocation: CLLocationCoordinate2D?
    
    private var locationManager: CLLocationManager?
    
    func requestLocation() {
            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager?.delegate = self
                locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            }
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            currentLocation = location.coordinate
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    
}
