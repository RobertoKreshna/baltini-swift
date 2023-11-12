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
    private var cart: Cart
    
    private init() {
        user = nil
        cart = Cart()
    }
    
    func setUser(user: User?){
        self.user = user
    }
    
    func getUser() -> User?{
        return user
    }
    
    func addProductToCart(item: ProductDetail, quantity: Int, varIndex: Int) {
        cart.products.append(item)
        cart.qty.append(quantity)
        cart.variantsIndex.append(varIndex)
    }
    
    func cartSetProtect(value: Bool){
        cart.useProtect = value
    }
    
    func cartSetAgreeTC(value: Bool){
        cart.agreeTC = value
    }
    
    func resetCart(){
        cart = Cart()
    }
}
