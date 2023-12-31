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
    private var searchHistory : [String]
    
    private init() {
        user = nil
        cart = Cart()
        searchHistory = [String]()
    }
    
    //user functions
    func setUser(user: User?){ self.user = user }
    
    func getUser() -> User?{ return user }
    
    //cart functions
    func cartSetProtect(value: Bool){ cart.useProtect = value }
    
    func cartGetProtect() -> Bool { return cart.useProtect }
    
    func cartGetAgreeTC() -> Bool { return cart.agreeTC }
    
    func cartSetAgreeTC(value: Bool){ cart.agreeTC = value }
    
    func getCartProducts() -> [ProductDetail] { return cart.products }
    
    func getQty() -> [Int] { return cart.qty }
    
    func getVariantsIndex() -> [Int] { return cart.variantsIndex }
    
    func getCartProductCount() -> Int { return cart.products.count }
    
    func resetCart(){ cart = Cart() }
    
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
        if let item = cart.recentlyDeleted, let qty = cart.recentlyDeletedQty, let varIndex = cart.recentlyDeletedVariantsIndex {
            addProductToCart(item: item, quantity: qty, varIndex: varIndex)
        }
        cart.recentlyDeleted = nil
        cart.recentlyDeletedQty = nil
        cart.recentlyDeletedVariantsIndex = nil
    }
    
    func minQtyAtIndex(index: Int) { if cart.qty[index] > 1 { cart.qty[index] = cart.qty[index] - 1 } }
    
    func plusQtyAtIndex(index: Int) { cart.qty[index] = cart.qty[index] + 1 }

    func calculateSubtotal() -> String{
        var res = 0.0
        
        if(cart.products.count >= 1){
            for i in 0...cart.products.count - 1 {
                res += Double(cart.products[i].price[cart.variantsIndex[i]]) * Double(cart.qty[i])
            }
        }
        if(cart.useProtect == true) { res += 22.00 }
        
        return String(format: "%.2f", res)
    }
    
    //search history functions
    
    func addSearchHistory(new: String){
        searchHistory.append(new)
        if searchHistory.count > 4 { searchHistory.removeFirst() }
    }
    
    func getSearchHistory() -> [String]{ return searchHistory }
}

class SortFilterValue {
    static let shared = SortFilterValue()
    
    private var sortValue: String
    private var filterKeys: [String]
    private var filterValues: [[String]]
    
    private init() {
        sortValue = "Featured"
        filterKeys = ["Gender", "Category", "Product Type", "Designer", "Size", "Price"]
        filterValues = [[],[],[],[],[],[]]
    }

    //sort functions
    func setSortValue(new: String){ self.sortValue = new }
    func getSortValue() -> String{ return sortValue }
    
    //filter functions
    func getFilterDictKeys() -> [String] { return filterKeys }
    func getFilterDictValues() -> [[String]] { return filterValues }
    
    func addFilterTo(key: String, value: [String]){
        for i in 0 ..< filterKeys.count {
            if filterKeys[i] == key { filterValues[i] = value }
        }
    }
}

struct FilterValue{
    let key: String
    let values: [String]
}
