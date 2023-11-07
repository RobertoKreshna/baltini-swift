//
//  ProductListViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 01/11/23.
//

import UIKit

class ProductListViewController : UIViewController {
    var productList: [Product]? = nil
    var sortValue: String = "Featured" {
        didSet { Task{ removeUI(); await loadData(); createUI(); } }
    }
    var filterValue: [String : [String]] = [
        "Gender" : [],
        "Category" : [],
        "ProductType" : [],
        "Designer" : [],
        "Size" : [],
        "Price" : [],
    ]
    
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
extension ProductListViewController {
    func loadData() async {
        let loading = CustomPopup.displayLoading(sender: self)
        self.view.addSubview(loading)
        let url = URL(string: "https://baltini-staging.myshopify.com/admin/api/2023-01/products.json?status=active")!
        var request = URLRequest(url: url)
        request.setValue(Constants.key, forHTTPHeaderField: "X-Shopify-Access-Token")
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any])
            self.productList = Product.fromJson(json: json)
        } catch {
            print("error gettting data")
        }
        loading.removeFromSuperview()
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        BackButton.addBackButton(to: stackView, title: "Product List", sender: self)
        CustomBanner.addPromotionBanner(to: stackView, spacing: 16)
        addFilterSort(to: stackView)
        
        if let list = productList {
            var index : Int = 0
            repeat {
                let itemStack = UIStackView()
                itemStack.axis = .horizontal
                itemStack.spacing = 16
                itemStack.translatesAutoresizingMaskIntoConstraints = false
                itemStack.distribution = .fillEqually

                let leftCard = CustomCard.createItemCard(product: list[index])
                leftCard.translatesAutoresizingMaskIntoConstraints = false
                leftCard.isUserInteractionEnabled = true
                let leftGestureRecognizer = ItemTapped(target: self, action: #selector(tapped(_:)), id: list[index].id)
                leftCard.addGestureRecognizer(leftGestureRecognizer)
                itemStack.addArrangedSubview(leftCard)
                
            
                let rightCard = CustomCard.createItemCard(product: list[index + 1 < productList!.count ? index + 1 :index])
                rightCard.alpha = index + 1 < productList!.count ? 1 : 0
                rightCard.translatesAutoresizingMaskIntoConstraints = false
                rightCard.isUserInteractionEnabled = true
                let rightGestureRecognizer = ItemTapped(target: self, action: #selector(tapped(_:)), id: list[index + 1 < productList!.count ? index + 1 :index].id)
                rightCard.addGestureRecognizer(rightGestureRecognizer)
                itemStack.addArrangedSubview(rightCard)
                
                itemStack.isLayoutMarginsRelativeArrangement = true
                itemStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
                
                stackView.addArrangedSubview(itemStack)
                //update condition
                index += 2
            } while index < productList!.count
        } else {
            CustomToast.showErrorToast(msg: "There are no product", sender: self)
        }
    }
    
    func addFilterSort(to stack: UIStackView){
        let filterButton = CustomButton.createFilterButton(tapped: UIAction(handler: { action in CustomBottomSheet.getFilterPopup(owner: self) }))
        let sortButton = CustomButton.createSortButton(value: sortValue, tapped: UIAction(handler: { action in CustomBottomSheet.getSortPopup(owner: self) }))
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually
        
        buttonStack.addArrangedSubview(filterButton)
        buttonStack.addArrangedSubview(sortButton)
        
        stack.addArrangedSubview(buttonStack)
        
        buttonStack.isLayoutMarginsRelativeArrangement = true
        buttonStack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
    @objc private func tapped(_ recognizer: ItemTapped){
        let vc = ProductDetailViewController()
        vc.productId = recognizer.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
