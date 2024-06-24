//
//  AddUserView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 4/6/24.
//

import SwiftUI
import CoreLocation

struct AddUserView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var favoriteColor = ""
    @State private var birthdate = Date()
    @State private var favoriteCity = ""
    @State private var favoriteNumber = ""
    @State private var currentLocation: CLLocationCoordinate2D?
    @ObservedObject var viewModel: UserViewModel
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView{
            VStack{
                addUserForm()
            }
            .navigationTitle("Add User")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    saveButtton
                }
            }
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var saveButtton: some View {
        Button("Save"){
            if let number = Int(favoriteNumber) {
                let user = User(name: name, favoriteColor: favoriteColor, birthdate: birthdate, favoriteCity: favoriteCity, favoriteNumber: number, currentLocation: locationManager.currentLocation)
                viewModel.addUser(user)
                presentationMode.wrappedValue.dismiss()                        }
        }
    }
    
    private func addUserForm () -> some View {
        Form {
            Section(header: Text("Personal information")){
                TextField("Name", text: $name)
                TextField("Favorite Color", text: $favoriteColor)
                DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                TextField("Favorite City", text: $favoriteCity)
                TextField("Favorite Number", text: $favoriteNumber).keyboardType(.numberPad)
            }
            Section{
                Button(action: {
                    locationManager.requestLocation()
                }){
                    Text("Get current location")
                }
            }
        }
        .padding(.vertical)
    }
    
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView(viewModel: UserViewModel(userRepository: UserRepositoryImpl()))
    }
}
