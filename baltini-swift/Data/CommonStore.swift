//
//  CommonStore.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import Foundation

class CommonStore {
    static let shared = CommonStore()
    private var user: User?
    
    private init() {
        user = nil
    }
    
    func setUser(user: User?){
        self.user = user
    }
    
    func getUser() -> User?{
        return user
    }
}
