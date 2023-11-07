//
//  ProductDetailViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 07/11/23.
//

import UIKit

class ProductDetailViewController : UIViewController {
    var productId: String?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        Task{
            removeUI()
            await loadData()
            createUI()
        }
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Load data by API
extension ProductDetailViewController {
    func loadData() async {
        let loading = CustomPopup.displayLoading(sender: self)
        if productId != nil {
            self.view.addSubview(loading)
            let url = URL(string: "https://baltini-staging.myshopify.com/admin/api/2023-01/products/\(productId!).json?status=active")!
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: "X-Shopify-Access-Token")
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any])!
                print(json)
            } catch {
                print("error gettting data")
            }
            loading.removeFromSuperview()
        } else {
            CustomToast.showErrorToast(msg: "Application Error (Dont have any id)", sender: self)
        }
    }
}

//MARK: Create UI Methods

extension ProductDetailViewController {
    func createUI(){
        print(productId)
    }
}
