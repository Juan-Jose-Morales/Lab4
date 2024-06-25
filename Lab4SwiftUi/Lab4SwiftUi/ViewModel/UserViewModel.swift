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
    
    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository){
        self.userRepository = userRepository
        self.users = userRepository.getAllUsers()
    }
    
    func addUser(_ user: User){
        userRepository.addUser(user)
        getAllUsers()
    }
    func deleteUser(_ user: User){
        userRepository.deleteUser(user)
        getAllUsers()
    }
    func updateUser(_ user: User){
        userRepository.updateUser(user)
        getAllUsers()
    }
    func filterUsers(by name:String){
        if name.isEmpty {
            self.users = userRepository.getAllUsers()
        } else {
            self.users = userRepository.getAllUsers().filter { $0.name.lowercased().contains(name.lowercased())}
        }
    }
    func getAllUsers() {
        self.users = userRepository.getAllUsers()
    }
}
