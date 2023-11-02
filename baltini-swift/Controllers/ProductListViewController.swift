//
//  ProductListViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 01/11/23.
//

import UIKit

class ProductListViewController : UIViewController {
    var productList: [Product]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let loading = CustomPopup.displayLoading(sender: self)
        Task{
            removeUI()
            self.view.addSubview(loading)
            await loadData()
            loading.removeFromSuperview()
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
extension ProductListViewController {
    func loadData() async {
        let url = URL(string: "https://baltini-staging.myshopify.com/admin/api/2023-01/products.json?status=active")!
        var request = URLRequest(url: url)
        request.setValue(Constants.key, forHTTPHeaderField: "X-Shopify-Access-Token")
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any])!
            self.productList = Product.fromJson(json: json)
        } catch {
            print("error gettting data")
        }
    }
}

//MARK: Create UI Methods

extension ProductListViewController {
    func createUI(){
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        if ((productList != nil)) {
            productList?.forEach({ product in
                let card = CustomCard.createItemCard(product: product)
                stackView.addArrangedSubview(card)
            })
        } else {
            print("bbbbb")
        }
    }
}
