//
//  ContentView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = UserViewModel(userRepository: UserRepositoryImpl())
    @State private var showingAddUserView = false
    
    var body: some View {
        NavigationView{
            VStack{
                List(viewModel.users) { user in
                    Text(user.name)
                }
                .navigationTitle("Users")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddUserView = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddUserView){
                    AddUserView(viewModel: viewModel)
                }
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
