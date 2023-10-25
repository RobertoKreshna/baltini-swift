//
//  CommonStore.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import Foundation

class CommonStore {
    static let shared = CommonStore()
    private var name: String?
    
    private init() {
        name = nil
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func getName() -> String?{
        return name
    }
}
