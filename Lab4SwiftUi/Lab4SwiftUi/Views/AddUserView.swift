//
//  AddUserView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 4/6/24.
//

import SwiftUI

struct AddUserView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var favoriteColor = ""
    @State private var birthdate = Date()
    @State private var favoriteCity = ""
    @State private var favoriteNumber = ""
    @ObservedObject var viewModel: UserViewModel
    
    
    var body: some View {
        NavigationView{
            VStack{
                Form {
                    TextField("Name", text: $name)
                    TextField("Favorite Color", text: $favoriteColor)
                    DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                    TextField("Favorite City", text: $favoriteCity)
                    TextField("Favorite Number", text: $favoriteNumber).keyboardType(.numberPad)
                }
                .padding(.vertical)
                .background(Color(UIColor.systemBackground))
            }
            .navigationTitle("Add User")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button("Save"){  
                        if let number = Int(favoriteNumber) {
                            let user = User(name: name, favoriteColor: favoriteColor, birthdate: birthdate, favoriteCity: favoriteCity, favoriteNumber: number)
                            viewModel.addUser(user)
                            presentationMode.wrappedValue.dismiss()                        }
                    }
                }
                
            }
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView(viewModel: UserViewModel(userRepository: UserRepositoryImpl()))
    }
}
