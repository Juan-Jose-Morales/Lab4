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
        users = userRepository.getAllUsers()
    }
    
    func getAllUsers() {
        users = userRepository.getAllUsers()
    }
}
