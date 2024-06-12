//
//  UserViewModel.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 4/6/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    
    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository){
        self.userRepository = userRepository
        self.users = userRepository.getAllUsers()
        self.filteredUsers = self.users
    }
    
    func addUser(_ user: User){
        userRepository.addUser(user)
        users = userRepository.getAllUsers()
        filteredUsers = users
    }
    func deleteUser(_ user: User){
        userRepository.deleteUser(user)
        users = userRepository.getAllUsers()
        filteredUsers = users
    }
    func updateUser(_ user: User){
        userRepository.updateUser(user)
        users = userRepository.getAllUsers()
        filteredUsers = users
    }
    func filterUsers(by name:String){
        if name.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { $0.name.lowercased().contains(name.lowercased())}
        }
    }
    func getAllUsers() {
        users = userRepository.getAllUsers()
        filteredUsers = users
    }
}
