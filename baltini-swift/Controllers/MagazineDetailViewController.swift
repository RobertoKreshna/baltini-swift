//
//  MagazineViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 08/12/23.
//

import UIKit

class MagazineDetailViewController: UIViewController {
    
    var magazine: Magazine?

    override func viewDidLoad() {
        super.viewDidLoad()
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
extension MagazineDetailViewController {
    
    func createUI(){
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //add all component to stack
        let backButton = BackButton.createBackButton(title: "Baltini Magazine" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let titleLabel = createLabel(text: magazine!.title, fontSize: 16, color: .black, align: .center)
        let quotes = createLabel(text: magazine!.quotes, fontSize: 14, color: .black, align: .center)
        let by = createLabel(text: "by \(magazine!.by)", fontSize: 12, color: .black.withAlphaComponent(0.5), align: .center)
        let image = UIImageView(image: UIImage(named: magazine!.imageName))
        let desc = createLabel(text: magazine!.desc, fontSize: 12, color: .black, align: .justified)
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(26, after: backButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(24, after: titleLabel)
        stackView.addArrangedSubview(quotes)
        stackView.setCustomSpacing(8, after: quotes)
        stackView.addArrangedSubview(by)
        stackView.setCustomSpacing(24, after: by)
        stackView.addArrangedSubview(image)
        stackView.setCustomSpacing(16, after: image)
        stackView.addArrangedSubview(desc)
        
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        quotes.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        quotes.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        by.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        by.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        image.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        desc.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        desc.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
    
    func createLabel(text: String, fontSize: CGFloat, color: UIColor, align: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text =  text
        label.font = UIFont(name: "Futura-Medium", size: fontSize)
        label.textColor = color
        label.numberOfLines = 0
        label.textAlignment = align
        
        return label
    }
}
