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

class UserRepositoryImpl: UserRepository {
    private let userDefaultsKey = "users"
    
    private var users: [User] {
            get {
                if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
                   let users = try? JSONDecoder().decode([User].self, from: data) {
                    return users
                }
                return []
            }
            set {
                if let data = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(data, forKey: userDefaultsKey)
                }
            }
        }
    
    func addUser(_ user: User) {
        var allUsers = users
        allUsers.append(user)
        users.append(user)
    }
    func deleteUser(_ user: User) {
        var allUsers = users
        allUsers.removeAll{ $0.id == user.id }
        users = allUsers
    }
    func updateUser(_ user: User) {
        var allUsers = users
        if let index = allUsers.firstIndex(where: { $0.id == user.id }){
            allUsers[index] = user
        }
        users = allUsers
    }
    
    func getAllUsers() -> [User] {
        return users
    }
}
