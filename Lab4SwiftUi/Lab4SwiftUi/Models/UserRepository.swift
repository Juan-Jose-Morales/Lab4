//
//  UserRepository.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 3/6/24.
//

import Foundation
import CoreLocation

protocol UserRepository {
    func addUser(_ user: User)
    func deleteUser(_ user: User)
    func updateUser(_ user: User)
    func getAllUsers() -> [User]
}

class UserRepositoryImpl: UserRepository {
    private let userDefaultsKey = "users"
    
    func getAllUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return []
    }
    
    func addUser(_ user: User) {
        var users = getAllUsers()
        users.append(user)
        savedUsers(users)
    }
    func deleteUser(_ user: User) {
        var users = getAllUsers()
        users.removeAll{ $0.id == user.id }
        savedUsers(users)
    }
    func updateUser(_ user: User) {
        var users = getAllUsers()
        if let index = users.firstIndex(where: { $0.id == user.id }){
            users[index] = user
        }
        savedUsers(users)
    }
    
    private func savedUsers(_ users: [User]){
        if let data = try? JSONEncoder().encode(users){
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
}
