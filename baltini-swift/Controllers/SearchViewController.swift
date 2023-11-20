//
//  SearchViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 20/11/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    var searchTimer: Timer?
    var searchRes = [Product]()
    var searchHistory = [String]()
    var currentlySearching = false
    
    var contentView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        removeUI()
        getSearchHistory()
        createUI()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Load Data
extension SearchViewController {
    func getSearchHistory(){
        searchHistory = CommonStore.shared.getSearchHistory()
    }
    
    func loadData(keyword: String) async {
        let url = URL(string: "https://baltini-staging.myshopify.com/admin/api/2023-01/products.json?status=active")!
        var request = URLRequest(url: url)
        request.setValue(Constants.key, forHTTPHeaderField: "X-Shopify-Access-Token")
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any])
            self.searchRes = searchByName(name: keyword, data: Product.fromJson(json: json)!)
        } catch {
            print("error gettting data")
        }
    }
    
    func searchByName(name: String, data: [Product]) -> [Product]{
        var res = [Product]()
        data.forEach { item in
            if item.name.contains(name){ res.append(item) }
        }
        return res
    }
}

//MARK: Create UI Methods
extension SearchViewController {
    func createUI(){
        print(searchHistory.count)
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
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
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackSearchBar(owner: self, backTapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: false)
        }))
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(24, after: backButton)
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        backButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        stackView.addArrangedSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }
    
    func getContent(){
        self.contentView.arrangedSubviews.forEach { subview in subview.removeFromSuperview() }
        if currentlySearching {
            displaySearchResult()
        } else {
            displayAllSearchHistory()
        }
    }
    
    func displaySearchResult(){
        if(searchRes.count > 0 ){
            let max = searchRes.count - 1 > 3 ? 3 : searchRes.count - 1
            for i in 0...max {
                let cell = CustomCell.createListCell(title: searchRes[i].name, useIcon: false, tapped: UITapGestureRecognizer(target: self, action: nil))
                
                contentView.addArrangedSubview(cell)
                cell.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
                cell.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
                
                if i == max { contentView.setCustomSpacing(16, after: cell) }
            }
            
            let viewAllButton = CustomButton.createUnderlinedButton(
                title: "VIEW ALL \(searchRes.count) PRODUCT",
                action: UIAction(handler: { action in
                    let vc = ProductListViewController()
                    vc.loadData = false
                    vc.productList = self.searchRes
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            )
            
            contentView.addArrangedSubview(viewAllButton)
        }
    }
    
    func displayAllSearchHistory(){
        searchHistory.forEach { history in
            let cell = CustomCell.createListCell(title: history, useIcon: false, tapped: UITapGestureRecognizer(target: self, action: nil))
            
            contentView.addArrangedSubview(cell)
            cell.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            cell.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        }
    }
}

//MARK: Textfield Delegate Methods
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            CommonStore.shared.addSearchHistory(new: textField.text!)
            textField.text = ""
        }
        currentlySearching = false
        DispatchQueue.main.async {
            self.getSearchHistory()
            self.getContent()
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        currentlySearching = true
        self.searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { timer in
            Task{
                await self.loadData(keyword: textField.text!)
                DispatchQueue.main.async { self.getContent() }
            }
        })
    }
}
