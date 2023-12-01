//
//  SortViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 30/11/23.
//
import UIKit

class SortViewController : UIViewController {
    var callBackAfterSet: (() -> Void)?
    
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
extension SortViewController {
    func createUI(){
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height * 0.5) + 32)
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        let contentView = CustomBottomSheet.createSortContent(
            selected: SortFilterValue.shared.getSortValue(),
            tapped: sortValueChanged,
            close: { self.dismiss(animated: false) }
        )
        view.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
    }
    
    func sortValueChanged(newValue: String){
        SortFilterValue.shared.setSortValue(new: newValue)
        callBackAfterSet!()
        self.dismiss(animated: false)
    }
}

