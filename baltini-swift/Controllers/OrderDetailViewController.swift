//
//  OrderDetailViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 29/11/23.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    var currentOrder: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        removeUI()
        createUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Create UI Methods
extension OrderDetailViewController {
    func createUI(){
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Order \(currentOrder!.id!)" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(30, after: backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        let orderIdSection = createSection(title: "Order Id", subtitle: currentOrder!.id!)
        stackView.addArrangedSubview(orderIdSection)
        stackView.setCustomSpacing(16, after: orderIdSection)
        
        let orderDateSection = createSection(title: "Order Date", subtitle: getStringFromDate(date: currentOrder!.orderDate!))
        stackView.addArrangedSubview(orderDateSection)
        stackView.setCustomSpacing(16, after: orderDateSection)
        
        let status = createStatusStack()
        stackView.addArrangedSubview(status)
        stackView.setCustomSpacing(24, after: status)
        
        let headerContentSeparator = CustomSeparator.createHorizontalLine(width: 2, color: .brandGray)
        stackView.addArrangedSubview(headerContentSeparator)
        stackView.setCustomSpacing(24, after: headerContentSeparator)
    }
    
    func createSection(title: String, subtitle: String) -> UIStackView {
        let section = UIStackView()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.axis = .vertical
        
        let titleLabel = UILabel()
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont(name: "Futura-Medium", size: 10)
        titleLabel.textColor = .black.withAlphaComponent(0.5)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont(name: "Futura-Medium", size: 16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
        
        section.addArrangedSubview(titleLabel)
        section.setCustomSpacing(4, after: titleLabel)
        section.addArrangedSubview(subtitleLabel)
        
        return section
    }
    
    func createStatusStack() -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        
        let randomStatus = createRandomStatus()
        randomStatus.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        row.addArrangedSubview(randomStatus)
        row.addArrangedSubview(spacer)
        
        return row
    }
    
    func createRandomStatus() -> UIStackView {
        let random = Int.random(in: 0...2)
        
        let status = UIStackView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.axis = .horizontal
        status.layer.cornerRadius = 14
        status.isLayoutMarginsRelativeArrangement = true
        status.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 8)
        
        if random == 0 {
            let imageName =  "icUnfulfilled"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.font = UIFont(name: "Futura-Medium", size: 11)
            label.text = "Unfulfilled"
            
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            status.backgroundColor = .unfulfilledBg
            
            status.addArrangedSubview(imageView)
            status.setCustomSpacing(4, after: imageView)
            status.addArrangedSubview(label)
        } else if random == 1 {
            let imageName =  "icPartiallyFulfilled"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.font = UIFont(name: "Futura-Medium", size: 11)
            label.text = "Partially Fulfilled"
            
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            status.backgroundColor = .partiallyFulfilledBg
            
            status.addArrangedSubview(imageView)
            status.setCustomSpacing(4, after: imageView)
            status.addArrangedSubview(label)
        } else if random == 2 {
            let imageName =  "icFulfilled"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.font = UIFont(name: "Futura-Medium", size: 11)
            label.textColor = .fulfilledText
            label.text = "Fulfilled"
            
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            status.backgroundColor = .fulfilledBg
            
            status.addArrangedSubview(imageView)
            status.setCustomSpacing(4, after: imageView)
            status.addArrangedSubview(label)
        }
        
        return status
    }
    
    func getStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, yyyy HH:mm a"
        return dateFormatter.string(from: date)
    }
}
