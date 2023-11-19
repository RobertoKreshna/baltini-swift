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
    
    func undoAdd(){
        cart.products.removeLast()
        cart.qty.removeLast()
        cart.variantsIndex.removeLast()
    }
    
    func removeProductFromCart(index: Int){
        cart.recentlyDeleted = cart.products.remove(at: index)
        cart.recentlyDeletedQty = cart.qty.remove(at: index)
        cart.recentlyDeletedVariantsIndex = cart.variantsIndex.remove(at: index)
    }
    
    func undoRemove(){
        cart.products.append(cart.recentlyDeleted!)
        cart.qty.append(cart.recentlyDeletedQty!)
        cart.variantsIndex.append(cart.recentlyDeletedVariantsIndex!)
        
        cart.recentlyDeleted = nil
        cart.recentlyDeletedQty = nil
        cart.recentlyDeletedVariantsIndex = nil
    }
    
    func cartSetProtect(value: Bool){
        cart.useProtect = value
    }
    
    func cartGetProtect() -> Bool {
        return cart.useProtect
    }
    
    func cartGetAgreeTC() -> Bool {
        return cart.agreeTC
    }
    
    func cartSetAgreeTC(value: Bool){
        cart.agreeTC = value
    }
    
    func resetCart(){
        cart = Cart()
    }
    
    func getCartProductsAtIndex(index: Int) -> ProductDetail {
        return cart.products[index]
    }
    
    func getQtyAtIndex(index: Int) -> Int {
        return cart.qty[index]
    }
    
    func getVariantsAtIndex(index: Int) -> Int {
        return cart.variantsIndex[index]
    }
    
    func getCartProductCount() -> Int {
        return cart.products.count
    }
    
    func minQtyAtIndex(index: Int) {
        let qtyAtIndex = cart.qty[index]
        if qtyAtIndex > 1 { cart.qty[index] = qtyAtIndex - 1 }
    }
    
    func plusQtyAtIndex(index: Int) {
        let qtyAtIndex = cart.qty[index]
        cart.qty[index] = qtyAtIndex + 1
    }

    func calculateSubtotal() -> String{
        var res = 0.0
        
        if(cart.products.count >= 1){
            for i in 0...cart.products.count - 1 {
                res += Double(cart.products[i].price[cart.variantsIndex[i]]) * Double(cart.qty[i])
            }
        }
        
        return String(format: "%.2f", res)
    }
}
