//
//  OrderViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import UIKit
import CoreData

class OrderViewController: UIViewController {
    
    var orders: [Order]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        removeUI()
        loadData()
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

//MARK: Load data method
extension OrderViewController{
    func loadData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = CommonStore.shared.getUser()
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        do {
            let allOrders = try context.fetch(request)
            var res = [Order]()
            allOrders.forEach { order in
                if order.belongsTo == user { res.append(order) }
            }
            orders = res
        } catch { CustomToast.showErrorToast(msg: "Failed to get all orders data", sender: self) }
    }
}

//MARK: Create UI Methods
extension OrderViewController {
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
        
        let titleLabel = UILabel()
        titleLabel.text = "My Order"
        titleLabel.font = UIFont(name: "Futura-Medium", size: 18)!
        
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(30, after: titleLabel)
        
        if orders!.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "There are no order yet"
            emptyLabel.font = UIFont(name: "Futura-Medium", size: 18)
            stackView.addArrangedSubview(emptyLabel)
        } else {
            for i in 0 ... orders!.count - 1 {
                //make card
                let card = createOrderCard(order: orders![i])
                stackView.addArrangedSubview(card)
                //make separator
                if i != orders!.count - 1 {
                    let separator = CustomSeparator.createHorizontalLine(width: 2, color: .brandGray)
                    stackView.setCustomSpacing(16, after: card)
                    stackView.addArrangedSubview(separator)
                    stackView.setCustomSpacing(16, after: separator)
                }
            }
        }
    }
    
    func createOrderCard(order: Order) -> UIStackView{
        let card = UIStackView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.axis = .vertical
        
        let idDateRow = createIdDateRow(id: order.id!, date: order.orderDate!)
        let status = createStatusStack()
        let products = order.has!.allObjects as! [OrderProduct]
        let firstItemRow = createItemRow(item: products[0])
        let totalRow = createTotalRow(total: calculateTotal(products: products, shippingCost: order.shippingCost!))
        
        card.addArrangedSubview(idDateRow)
        card.setCustomSpacing(4, after: idDateRow)
        card.addArrangedSubview(status)
        card.setCustomSpacing(8, after: status)
        card.addArrangedSubview(firstItemRow)
        card.setCustomSpacing(8, after: firstItemRow)
        card.addArrangedSubview(totalRow)
        
        idDateRow.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        idDateRow.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        
        return card
    }
    
    func createIdDateRow(id: String, date: Date) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.distribution = .equalCentering
        
        let idLabel = UILabel()
        idLabel.text = id
        idLabel.font = UIFont(name: "Futura-Medium", size: 12)
        idLabel.textColor = .black.withAlphaComponent(0.5)
        
        let dateLabel = UILabel()
        dateLabel.text = getStringFromDate(date: date)
        dateLabel.font = UIFont(name: "Futura-Medium", size: 12)
        dateLabel.textColor = .black.withAlphaComponent(0.5)
        
        row.addArrangedSubview(idLabel)
        row.addArrangedSubview(dateLabel)
        
        return row
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
    
    func createItemRow(item: OrderProduct) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .leading
        
        let itemImageView = UIImageView()
        if(item.imageName == "http://placekitten.com/200/300"){
            itemImageView.image = UIImage(named: "productPlaceholder")
        } else {
            itemImageView.imageFromServerURL(item.imageName!, placeHolder: UIImage(named: "productPlaceholder"))
        }
        
        let itemDesc = createItemDesc(brand: item.brand!, name: item.name!, size: item.size!, price: item.price!, qty: item.quantity)
        
        row.addArrangedSubview(itemImageView)
        row.setCustomSpacing(8, after: itemImageView)
        row.addArrangedSubview(itemDesc)
        
        itemImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return row
    }
    
    func createItemDesc(brand: String, name: String, size: String, price: String, qty: Double) -> UIStackView {
        let labelStack = UIStackView()
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        
        let brandLabel = UILabel()
        brandLabel.text = brand
        brandLabel.font = UIFont(name: "Futura-Bold", size: 14)!
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let variantLabel = UILabel()
        variantLabel.text = size
        variantLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        variantLabel.textColor = .black.withAlphaComponent(0.5)
        
        let priceLabel = UILabel()
        priceLabel.text = "$\(price) x \(Int(qty))"
        priceLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        labelStack.addArrangedSubview(brandLabel)
        labelStack.setCustomSpacing(4, after: brandLabel)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.setCustomSpacing(4, after: nameLabel)
        labelStack.addArrangedSubview(variantLabel)
        labelStack.setCustomSpacing(8, after: variantLabel)
        labelStack.addArrangedSubview(priceLabel)
        
        return labelStack
    }
    
    func createTotalRow(total: String) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        
        let titleLabel = UILabel()
        titleLabel.text = "Total Price"
        titleLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        titleLabel.textAlignment = .right
        
        let totalLabel = UILabel()
        totalLabel.text = total
        totalLabel.font = UIFont(name: "Futura-Medium", size: 18)!
        totalLabel.textAlignment = .right
        totalLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        row.addArrangedSubview(titleLabel)
        row.setCustomSpacing(10, after: titleLabel)
        row.addArrangedSubview(totalLabel)
        
        return row
    }
}

//MARK: Display Logic
extension OrderViewController {
    func getStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, yyyy HH:mm a"
        return dateFormatter.string(from: date)
    }
    
    func calculateTotal(products: [OrderProduct], shippingCost: String) -> String {
        var res = 0.0
        products.forEach { product in res = res + Double(product.price!)! * product.quantity }
        res = res + (shippingCost.trimmingPrefix("$") as NSString).doubleValue
        return String(format: "$%.2f", res)
    }
}
