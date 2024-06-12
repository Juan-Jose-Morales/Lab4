//
//  User.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import Foundation
import CoreLocation

struct User: Identifiable, Codable {
    var id = UUID()
    var name: String
    var favoriteColor: String
    var birthdate: Date
    var favoriteCity: String
    var favoriteNumber: Int
    var currentLocation: CLLocationCoordinate2D? = nil
    
    enum CodingKeys: String, CodingKey {
        case id,name,favoriteColor,birthdate,favoriteCity,favoriteNumber,currentLocation
    }
    
    struct Location: Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var location: Location? {
        guard let currentLocation = currentLocation else {return nil }
        return Location(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
    }
    
    init(name: String, favoriteColor: String, birthdate: Date, favoriteCity: String, favoriteNumber: Int, currentLocation: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.favoriteColor = favoriteColor
        self.birthdate = birthdate
        self.favoriteCity = favoriteCity
        self.favoriteNumber = favoriteNumber
        self.currentLocation = currentLocation
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        favoriteColor = try container.decode(String.self, forKey: .favoriteColor)
        birthdate = try container.decode(Date.self, forKey: .birthdate)
        favoriteCity = try container.decode(String.self, forKey: .favoriteCity)
        favoriteNumber = try container.decode(Int.self, forKey: .favoriteNumber)
        if let location = try container.decodeIfPresent(Location.self, forKey: .currentLocation){
            currentLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
    }
    
    func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(id, forKey: .id)
           try container.encode(name, forKey: .name)
           try container.encode(favoriteColor, forKey: .favoriteColor)
           try container.encode(birthdate, forKey: .birthdate)
           try container.encode(favoriteCity, forKey: .favoriteCity)
           try container.encode(favoriteNumber, forKey: .favoriteNumber)
           try container.encode(location, forKey: .currentLocation)
       }
}
