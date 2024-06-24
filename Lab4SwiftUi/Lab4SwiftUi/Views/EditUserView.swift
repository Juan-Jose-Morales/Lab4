//
//  EditUserView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 18/6/24.
//

import SwiftUI
import CoreLocation

struct EditUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var user: User
    @ObservedObject var viewModel: UserViewModel
    @ObservedObject private var locationManager = LocationManager()
    var body: some View {
        NavigationView {
            VStack {
                editUserForm()
            }
            .navigationTitle("Edit User")
            .navigationBarItems(trailing: saveButton)
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            saveChanges()
        }
    }
    
    private func saveChanges() {
        user.currentLocation = locationManager.currentLocation
        viewModel.updateUser(user)
        presentationMode.wrappedValue.dismiss()
    }
    
    private func editUserForm() -> some View {
        Form {
            Section(header: Text("Personal information")){
                TextField("Name", text: $user.name)
                TextField("Favorite Color", text: $user.favoriteColor)
                DatePicker("Birthdate", selection: $user.birthdate, displayedComponents: .date)
                TextField("Favorite City", text: $user.favoriteCity)
                TextField("Favorite Number", value: $user.favoriteNumber, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            Section {
                Button(action: {
                    locationManager.requestLocation()
                }) {
                    Text("Get Current Location")
                }
            }
        }
        .padding(.vertical)
        .background(Color(UIColor.systemBackground))
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(name: "Juan", favoriteColor: "Blue", birthdate: Date(), favoriteCity: "Miami", favoriteNumber: 18)
        EditUserView(user: user, viewModel: UserViewModel(userRepository: UserRepositoryImpl()))
    }
}
