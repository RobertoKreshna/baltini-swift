//
//  DesignerFilterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 07/12/23.
//

import UIKit

class DesignerFilterViewController : UIViewController {
    let designers = [
        "Adidas", "A|X Armani Exchange", "Bally", "Birkenstock", "Bottega Veneta", "Calvin Klein", "Cartier", "CAT", "Champion", "Comme Des Garçons",
        "DC", "DKNY", "Dolce & Gabbana", "Emporio Armani", "Ermenegildo Zegna", "Ferragamo", "Fossil", "Free People", "Geox", "Giorgio Armani",
        "Givenchy", "Gucci", "Havaianas", "Helmut Lang", "Hermès", "Issey Miyake", "J.W.Anderson", "Kate Spade", "Kenzo", "Kurt Geiger",
        "Loewe", "Louis Vuitton", "Love Moschino", "Marc Jacobs", "Michael Kors", "Miu Miu", "New Era", "Nine West", "Off-white", "Palm Angels",
        "Polo Ralph Lauren", "Prada", "Quiksilver", "Raf Simons", "Ralph Lauren", "sacai", "Saint Laurent", "Skechers", "Stella McCartney", "Swarovski",
        "Ted Baker", "Tommy Hilfiger", "Tory Burch", "Under Armour", "Urban Shop", "Valentino", "Vans", "Versace", "Wacoal", "Wrangler", "XBK Milano",
        "Yohji Yamamoto", "You the Fan", "Zara", "Zojirushi", "Zwilling", "0039 Italy", "19.70 Nineteen Seventy", "24th & Ocean","3.1 Phillip Lim",
        "47 Brand", "54 Thrones", "6 Punto 9", "7.24", "813", "9.2 By Carlo Chionna",
    ]
    
    var searchRes : [String] = [String]()
    var keyword : String = ""
    
    var contentView: UIStackView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRes = designers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        removeUI()
        createUI()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Create UI methods
extension DesignerFilterViewController {
    func createUI(){
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.66)
        view.backgroundColor = .white
        
        let button = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in
            var res = [String]()
            let allTiles = self.getAllTilesFromPage()
            allTiles.forEach { tile in
                let imageView = tile.arrangedSubviews[0] as! UIImageView
                let label = tile.arrangedSubviews[1] as! UILabel
                if imageView.image == UIImage(named: "icCheckSelected") { res.append(label.text!) }
            }
            SortFilterValue.shared.addFilterTo(key: "Designer", value: res)
            self.navigationController?.popViewController(animated: true)
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
       
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12).isActive = true
        
        contentView = CustomBottomSheet.createCheckboxListFilterContentWithSearchBar(
            title: "FILTER - DESIGNER",
            data: searchRes,
            selectedData: SortFilterValue.shared.getFilterDictValues()[3],
            owner: self,
            searchKeyword: keyword,
            close: { self.navigationController?.popViewController(animated: true) }
        )
        
        scrollView.addSubview(contentView!)
        
        contentView!.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView!.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

//MARK: UITextfieldDelegate
extension DesignerFilterViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyword = textField.text!
        if(keyword.isEmpty){
            searchRes = designers
        } else {
            var res = [String]()
            designers.forEach { brand in if(brand.contains(keyword)){ res.append(brand) }}
            searchRes = res
        }
        removeUI()
        createUI()
    }
}

//MARK: Logic
extension DesignerFilterViewController {
    func getAllTilesFromPage() -> [UIStackView] {
        let subviews = contentView?.arrangedSubviews
        var res: [UIStackView] = [UIStackView]()
        for i in 3 ..< subviews!.count {
            res.append(subviews![i] as! UIStackView)
        }
        return res
    }
}
