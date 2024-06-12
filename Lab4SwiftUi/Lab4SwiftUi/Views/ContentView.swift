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
            ZStack{
                background()
                VStack{
                    List(viewModel.users) { user in
                        Text(user.name)
                    }
                    .padding(.top)
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
    private func background() -> some View {
            return Color.purple.ignoresSafeArea()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
