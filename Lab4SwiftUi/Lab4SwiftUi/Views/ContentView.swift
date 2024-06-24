//
//  ContentView.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: UserViewModel
    @State private var searchText = ""
    @State private var showingAddUserView = false
    @State private var showingEditUserView = false
    @State private var selectedUser: User?
    
    var body: some View {
        NavigationView{
            ZStack{
                background()
                VStack (spacing: 10){
                    
                    userList()
                }
                .padding(.top,10)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Users")
                .padding(.bottom)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addUserButton
                    }
                }
                .sheet(isPresented: $showingAddUserView) {
                    AddUserView(viewModel: viewModel)
                }
                .sheet(item: $selectedUser){ user in
                    EditUserView(user: user, viewModel: viewModel)
                }
                .searchable(text: $searchText)
            }
        }
    }
    
    private var addUserButton: some View {
        Button(action: {
            showingAddUserView = true
        }){
            Image(systemName: "plus")
        }
    }
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else{
            return viewModel.users.filter{ $0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    private func userList() -> some View {
        List {
            ForEach(filteredUsers) { user in
                NavigationLink(destination: UserDetailsView(user: user)){
                    Text(user.name)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive){
                        showDeleteAlert(for: user)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    Button {
                        navigateToEditUser(user: user)
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
        }
    }
    private func delete(at offsets: IndexSet) {
        offsets.map{ viewModel.users[$0]}.forEach(viewModel.deleteUser)
    }
    private func showDeleteAlert(for user: User) {
        let alert = UIAlertController(title: "Delete User", message: "Are you sure you want to delete this user?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive){ _ in
            viewModel.deleteUser(user)
        })
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    private func navigateToEditUser(user: User) {
        selectedUser = user
        showingEditUserView = true
    }
    private func background() -> some View {
        return Color("Gray").ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: UserViewModel(userRepository: UserRepositoryImpl()))
    }
}
