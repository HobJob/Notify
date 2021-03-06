//
//  UserRepository.swift
//  Notify
//
//  Created by Alumne on 12/11/2020.
//

import Foundation

class UserRepository {
    enum Key: String, CaseIterable {
        case name, avatarData, notificationID
        func make(for userID: String) -> String {
            return self.rawValue + "_" + userID
        }
    }
    
    let userDefaults: UserDefaults
    // MARK: - Lifecycle
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    // MARK: - API
    func storeInfo(forUserID userID: String, name: [String], avatarData: [Bool], notificationIDs: [String]) {
        saveValue(forKey: .name, value: name, userID: userID)
        saveValue(forKey: .avatarData, value: avatarData, userID: userID)
        saveValue(forKey: .notificationID, value: notificationIDs, userID: userID)
    }
    
    func getUserInfo(forUserID userID: String) -> (name: [String]?, avatarData: [Bool]?, notificationIDs: [String]?) {
        let name: [String]? = readValue(forKey: .name, userID: userID)
        let avatarData: [Bool]? = readValue(forKey: .avatarData, userID: userID)
        let notificationIDs: [String]? = readValue(forKey: .notificationID, userID: userID)
        return (name, avatarData, notificationIDs)
    }
    
    func removeUserInfo(forUserID userID: String) {
        Key
            .allCases
            .map { $0.make(for: userID) }
            .forEach { key in
                userDefaults.removeObject(forKey: key)
        }
    }
    // MARK: - Private
    private func saveValue(forKey key: Key, value: Any, userID: String) {
        userDefaults.set(value, forKey: key.make(for: userID))
    }
    private func readValue<T>(forKey key: Key, userID: String) -> T? {
        return userDefaults.value(forKey: key.make(for: userID)) as? T
    }
}
