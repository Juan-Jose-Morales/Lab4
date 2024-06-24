//
//  UserDetailsView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 12/6/24.
//

import SwiftUI
import CoreLocation

struct UserDetailsView: View {
    var user: User
    
    @State private var isShowingMapView = false
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                detailRows
                showMapViewButton
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .navigationTitle("User Details")
    }
    
    private var detailRows: some View {
        VStack(alignment: .leading, spacing: 10) {
            DetailRow(title: "Name:", value: user.name)
            DetailRow(title: "Favorite Color:", value: user.favoriteColor)
            DetailRow(title: "Birthdate:", value: formatDate(user.birthdate))
            DetailRow(title: "Favorite City:", value: user.favoriteCity)
            DetailRow(title: "Favorite Number:", value: "\(user.favoriteNumber)")
        }
    }
    
    private var showMapViewButton: some View {
        Button(action: {
            isShowingMapView = true
        }) {
            Text("Show Favorite City on Map")
                .buttonStyle(MainButtonStyle())
        }
        .sheet(isPresented: $isShowingMapView) {
            mapViewSheet
        }
        .padding(.top, 20)
    }
    
    private var mapViewSheet: some View {
        MapView(location: user.favoriteCity, isShowingMapView: $isShowingMapView)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Button(action: {
                    isShowingMapView = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                        .padding(.top, 30) // Ajuste para alinear la X
                }
                    .padding(.trailing, 20) // Ajuste para alinear la X
                , alignment: .topTrailing
            )
    }
        
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(name: "Juan", favoriteColor: "Blue", birthdate: Date(), favoriteCity: "Miami", favoriteNumber: 18)
        UserDetailsView(user: user)
    }
}
