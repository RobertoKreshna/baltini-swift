//
//  OrderViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import UIKit
import CoreData

class OrderViewController: UIViewController {
    
    var orders: [Order]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        loadData()
        createUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Load data method
extension OrderViewController{
    func loadData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = CommonStore.shared.getUser()
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        do {
            let allOrders = try context.fetch(request)
            var res = [Order]()
            allOrders.forEach { order in
                if order.belongsTo == user { res.append(order) }
            }
            orders = res
        } catch { CustomToast.showErrorToast(msg: "Failed to get all orders data", sender: self) }
    }
}

//MARK: Create UI Methods
extension OrderViewController {
    func createUI(){
        view.backgroundColor = .systemBlue
        
        print(orders?.count)
    }
}
