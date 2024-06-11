//
//  UserRepository.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import Foundation

protocol UserRepository {
    func addUser(_ user: User)
    func deleteUser(_ user: User)
    func updateUser(_ user: User)
    func getAllUsers() -> [User]
}

class UserRepositoryImpl: UserRepository{
   
    private var users: [User] = []
    
    func addUser(_ user: User) {
        users.append(user)
    }
    func deleteUser(_ user: User) {
        users.removeAll{ $0.id == user.id }
}
    func updateUser(_ user: User) {
        
        if let index = users.firstIndex(where: { $0.id == user.id }){
            users[index] = user
        }
    }
    
    func getAllUsers() -> [User] {
        return users
    }
}
