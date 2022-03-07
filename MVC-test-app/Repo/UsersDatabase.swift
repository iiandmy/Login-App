import Foundation

class UsersDatabase {
    
    private static var instance: UsersDatabase!
    
    private var users: [User]!
    
    private let currentUser: User? = nil
    
    func isValid(user: User) -> Bool {
        return users.contains(where: {
            $0.login == user.login && $0.password == user.password
        })
    }
    
    func updateDatabase() {
        users = [
            User(login: "ilya2003", password: "Sashik"),
            User(login: "sasha228vip", password: "Iluyha")
        ]
    }
    
    private init() {
        updateDatabase()
    }
    
    func add(user: User) -> Bool {
        if users.contains(where: {
            $0.login == user.login
        }) {
            return false
        }
        users.append(user)
        return true
    }
    
    func getUserWith(login: String) -> User? {
        return users.first(where: { $0.login == login })
    }
    
    static func getStorageInstanse() -> UsersDatabase {
        guard let instance = self.instance else {
            self.instance = UsersDatabase()
            return self.instance
        }
        return instance
    }
    
}
