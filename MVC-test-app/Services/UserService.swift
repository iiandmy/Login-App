//
//  UserService.swift
//  MVC-test-app
//
//  Created by IlyaCool on 7.03.22.
//

import Foundation

class UserService {
    
    private static var instance: UserService!
    
    private let userRepository: UsersDatabase!
    
    var currentUser: User!
    
    private init() {
        userRepository = UsersDatabase.getStorageInstanse()
    }
    
    func getUserWith(login: String) -> User? {
        return userRepository.getUserWith(login: login)
    }
    
    func logIn(user: User) -> Bool {
        guard
            userRepository.isValid(user: user)
        else {
            return false
        }
        currentUser = user
        return true
    }
    
    func register(user: User) -> Bool {
        return userRepository.add(user: user)
    }
    
    static func getInstanse() -> UserService {
        guard
            let instance = self.instance
        else {
            self.instance = UserService()
            return self.instance
        }
        return instance
    }
    
}
