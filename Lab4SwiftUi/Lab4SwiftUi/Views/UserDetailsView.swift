//
//  UserDetailsView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 12/6/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct UserDetailsView: View {
    
    var user: User
    var body: some View {
        
        VStack (alignment: .leading) {
            Text("Name: \(user.name)")
            Text("Favorite Color: \(user.favoriteColor)")
            Text("Birthdate: \(user.favoriteCity)")
            Text("Favorite City: \(user.favoriteCity)")
            Text("Favorite Number: \(user.favoriteNumber)")
            if let location = user.currentLocation {
                Text("Current Location: \(location.latitude), \(location.longitude)")
            }
           // NavigationLink(destination: MapView(city: user.favoriteCity)){
           //     Text("View on Map")
           // }
           // .padding(.top)
            Spacer()
        }
        .padding()
        .navigationTitle("User Details")
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(name: "Juan", favoriteColor: "Blue", birthdate: Date(), favoriteCity: "Miami", favoriteNumber: 18)
        UserDetailsView(user: user)
    }
}
