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
        
        VStack (alignment: .leading, spacing: 16) {
            userInfoRow(title: "Name:", value: user.name)
            userInfoRow(title: "Favorite Color: ", value: user.favoriteColor)
            userInfoRow(title: "Birthday:", value: formmattedDate)
            userInfoRow(title: "Favortite City:", value: user.favoriteCity)
            userInfoRow(title: "Favorite Number: ", value: "\(user.favoriteNumber)")
            if let location = user.currentLocation {
                Text("Current Location: \(location.latitude), \(location.longitude)")
            }
            // NavigationLink(destination: MapView(city: user.favoriteCity)){
            //     Text("View on Map")
            // }
            // .padding(.top)
        }
        Spacer()
        .navigationTitle("User Details")
        
    }
    
    private func userInfoRow (title: String, value: String) -> some View {
        HStack{
            Text(title)
                .frame(width: 120, alignment: .leading)
                .modifier(UserInfoLabel())
            Text(value)
                .modifier(UserInfoText())
        }
    }
    
    private var formmattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: user.birthdate)
    }
}
struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(name: "Juan", favoriteColor: "Blue", birthdate: Date(), favoriteCity: "Miami", favoriteNumber: 18)
        UserDetailsView(user: user)
    }
}
