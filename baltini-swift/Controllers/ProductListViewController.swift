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
    var filterValue: KeyValuePairs<String, [String]> = [
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
        self.tabBarController?.tabBar.isHidden = true
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
        stackView.alignment = .center
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        addSearchCartBar(to: stackView)
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
                
                stackView.addArrangedSubview(itemStack)
                itemStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
                itemStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
                
                //update condition
                index += 2
            } while index < productList!.count
        } else {
            CustomToast.showErrorToast(msg: "There are no product", sender: self)
        }
    }
    
    func addSearchCartBar(to stack: UIStackView) {
        let searchCartBar = BackButton.createBackSearchCartBar(
            owner: self,
            cartTapped: UIAction(handler: { action in self.goToCart() })
        )
        
        stack.addArrangedSubview(searchCartBar)
        searchCartBar.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        searchCartBar.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
    
    func addFilterSort(to stack: UIStackView){
        let filterButton = CustomButton.createFilterButton(tapped: UIAction(handler: { action in
            var keys: [String] = []
            var values : [[String]] = []
            for i in 0..<self.filterValue.count { keys.append(self.filterValue[i].key); values.append(self.filterValue[i].value) }
            CustomBottomSheet.getFilterPopup(
                keys: keys,
                values: values,
                tapped: [
                    UITapGestureRecognizer(target: self, action: #selector(self.genderFilterPressed)),
                    UITapGestureRecognizer(target: self, action: #selector(self.categoryFilterPressed)),
                    UITapGestureRecognizer(target: self, action: #selector(self.productTypeFilterPressed)),
                    UITapGestureRecognizer(target: self, action: #selector(self.designerFilterPressed)),
                    UITapGestureRecognizer(target: self, action: #selector(self.sizeFilterPressed)),
                    UITapGestureRecognizer(target: self, action: #selector(self.priceFilterPressed))
                ],
                owner: self
            )
        }))
        let sortButton = CustomButton.createSortButton(value: sortValue, tapped: UIAction(handler: { action in
            CustomBottomSheet.getSortPopup(selected: self.sortValue, tapped: self.sortValueChanged, owner: self)
        }))
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 16
        buttonStack.distribution = .fillEqually
        
        buttonStack.addArrangedSubview(filterButton)
        buttonStack.addArrangedSubview(sortButton)
        
        stack.addArrangedSubview(buttonStack)
        buttonStack.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        buttonStack.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
    
    func sortValueChanged(newValue: String){
        sortValue = newValue
    }
}

//MARK: Navigations

extension ProductListViewController {
    @objc private func tapped(_ recognizer: ItemTapped){
        let vc = ProductDetailViewController()
        vc.productId = recognizer.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToCart(){
        self.navigationController?.pushViewController(CartViewController(), animated: true)
    }
    
    @objc private func genderFilterPressed() {
        print("Gender")
    }
    
    @objc private func categoryFilterPressed() {
        print("Category")
    }
    
    @objc private func productTypeFilterPressed() {
        print("Product Type")
    }
    
    @objc private func designerFilterPressed() {
        print("Designer")
    }
    
    @objc private func sizeFilterPressed() {
        print("Size")
    }
    
    @objc private func priceFilterPressed() {
        print("Price")
    }
}
