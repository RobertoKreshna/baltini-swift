//
//  SizeFilterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 04/12/23.
//

import UIKit

class SizeFilterViewController : UIViewController {
    let sizes = [
        "XXXS", "XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL", "One Size", "90", "100", "110", "115", "125", "135",
        "Women 5 US", "Women 5.5 US", "Women 6 US", "Women 6.5 US", "Women 7 US", "Women 7.5 US", "Women 8 US", "Women 8.5 US",
        "Women 9 US", "Women 9.5 US", "Women 10 US", "Women 10.5 US", "Women 11 US", "Women 11.5 US", "Women 12 US", "Women 12.5 US",
        "Men 5 US", "Men 5.5 US", "Men 6 US", "Men 6.5 US", "Men 7 US", "Men 7.5 US", "Men 8 US", "Men 8.5 US",
        "Men 9 US", "Men 9.5 US", "Men 10 US", "Men 10.5 US", "Men 11 US", "Men 11.5 US", "Men 12 US", "Men 12.5 US"
    ]
    
    var contentView: UIStackView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension SizeFilterViewController {
    func createUI(){
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = .white
        
        let button = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in
            var res = [String]()
            let allTiles = self.getAllTilesFromPage()
            allTiles.forEach { tile in
                let imageView = tile.arrangedSubviews[0] as! UIImageView
                let label = tile.arrangedSubviews[1] as! UILabel
                if imageView.image == UIImage(named: "icCheckSelected") { res.append(label.text!) }
            }
            SortFilterValue.shared.addFilterTo(key: "Size", value: res)
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
        
        
        contentView = CustomBottomSheet.createCheckboxListFilterContent(
            title: "FILTER - SIZE",
            data: sizes,
            selectedData: SortFilterValue.shared.getFilterDictValues()[4],
            close: { self.navigationController?.popViewController(animated: true) }
        )
        scrollView.addSubview(contentView!)
        
        contentView!.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView!.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}


//MARK: Logic
extension SizeFilterViewController {
    func getAllTilesFromPage() -> [UIStackView] {
        let subviews = contentView?.arrangedSubviews
        var res: [UIStackView] = [UIStackView]()
        for i in 2 ..< subviews!.count {
            res.append(subviews![i] as! UIStackView)
        }
        return res
    }
}
