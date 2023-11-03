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
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        BackButton.addBackButton(to: stackView, title: "Product List", sender: self)
        
        if ((productList != nil)) {
            var index : Int = 0
            repeat {
                let stack = UIStackView()
                stack.axis = .horizontal
                stack.spacing = 16

                let leftCard = CustomCard.createItemCard(product: productList![index])
                stack.addArrangedSubview(leftCard)
            
                let rightCard = CustomCard.createItemCard(product: productList![index + 1 < productList!.count ? index + 1 :index])
                rightCard.alpha = index + 1 < productList!.count ? 1 : 0
                stack.addArrangedSubview(rightCard)
                
                stackView.addArrangedSubview(stack)

                //update condition
                index += 2
            } while index < productList!.count
        } else {
            CustomToast.showErrorToast(msg: "There are no product", sender: self)
        }
    }
}
