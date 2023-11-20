//
//  DesignerViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 14/11/23.
//

import UIKit

class DesignerViewController: UIViewController{
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRes = designers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
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

//MARK: Create UI Methods

extension DesignerViewController {
    func createUI(){
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
        stackView.spacing = 4
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Designers" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        stackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        stackView.setCustomSpacing(24, after: stackView.arrangedSubviews.last!)
        
        let searchTextfield = CustomTextfield.createFilledSearchBar(owner: self, placeholder: "Search designer", text: keyword)
        
        stackView.addArrangedSubview(searchTextfield)
        searchTextfield.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        searchTextfield.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        searchRes.forEach { brand in
            let row = CustomCell.createListCell(
                title: brand,
                useIcon: false,
                tapped: UITapGestureRecognizer(target: self, action: #selector(tapped))
            )
            stackView.addArrangedSubview(row)
            row.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
            row.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        }
    }
}

//MARK: Textfield Delegate
extension DesignerViewController : UITextFieldDelegate{
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
        searchDesigner(keyword: keyword)
    }
}

//MARK: TAPPED
extension DesignerViewController {
    @objc func tapped(){
        print("tapped")
    }
}

//MARK: Search Methods
extension DesignerViewController {
    func searchDesigner(keyword: String){
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
