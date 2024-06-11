//
//  User.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import Foundation
import CoreLocation

struct User: Identifiable{
    let id = UUID()
    var name: String
    var favoriteColor: String
    var birthdate: Date
    var favoriteCity: String
    var favoriteNumber: Int
    var currentLocation: CLLocationCoordinate2D? = nil
}
