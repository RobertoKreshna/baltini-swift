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
        view.backgroundColor = .black.withAlphaComponent(0.2)
        
        let contentView = CustomBottomSheet.createSortContent(
            selected: SortFilterValue.shared.getSortValue(),
            tapped: sortValueChanged,
            close: { self.dismiss(animated: false) }
        )
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction(handler: { action in self.dismiss(animated: false)}),
            for: .touchUpInside
        )
        
        view.addSubview(button)
        view.addSubview(contentView)

        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func sortValueChanged(newValue: String){
        SortFilterValue.shared.setSortValue(new: newValue)
        callBackAfterSet!()
        self.dismiss(animated: false)
    }
}

