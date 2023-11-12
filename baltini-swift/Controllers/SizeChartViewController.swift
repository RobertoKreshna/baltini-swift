//
//  SizeChartViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 09/11/23.
//

import UIKit

class SizeChartViewController : UIViewController {
    let order = ["Clothing", "Jeans", "Shoes", "Hats", "Gloves", "Belts", "Rings", "Eyewear"]
    var showChart = [
        "Clothing" : true,
        "Jeans" : false,
        "Shoes" : false,
        "Hats" : false,
        "Gloves" : false,
        "Belts" : false,
        "Rings" : false,
        "Eyewear" : false
    ]
    
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

//MARK: Create UI Methods
extension SizeChartViewController {
    func createUI(){
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
        stackView.spacing = 16
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        BackButton.addBackButton(to: stackView, title: "Size Chart", icName: "icClose",  sender: self, usePadding: true)
        order.forEach { key in
            let row = createRow(title: key , showChart: showChart[key]!)
            stackView.addArrangedSubview(row)
            
            row.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            row.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
    }
    
    func createRow(title: String, showChart: Bool) -> UIStackView{
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        
        let titleRow = createTitleRow(title: title, showChart: showChart)
        contentStack.addArrangedSubview(titleRow)
        contentStack.setCustomSpacing(14, after: titleRow)
        
        if(showChart == true){
            let chart = createChart()
            contentStack.addArrangedSubview(chart)
            contentStack.setCustomSpacing(16, after: chart)
        }
        
        return contentStack
    }
    
    func createTitleRow(title: String, showChart: Bool) -> UIStackView{
        let titleRow = UIStackView()
        titleRow.axis = .horizontal
        titleRow.distribution = .equalCentering
        titleRow.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = attributedTitle
        
        let toggleButton = UIButton(type: .system)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setImage(UIImage(named: showChart ? "icUp" : "icDown")?.withRenderingMode(.alwaysOriginal), for: .normal)
        toggleButton.addAction(UIAction(handler: { pressed in self.iconPressed(title: title) }), for: .touchUpInside)
        
        titleRow.addArrangedSubview(titleLabel)
        titleRow.addArrangedSubview(toggleButton)
        
        return titleRow
    }
    
    func createChart() -> UIStackView{
        //create per column
        
        let chart = UIStackView()
        chart.axis = .horizontal
        chart.translatesAutoresizingMaskIntoConstraints = false
        
        let standartColumn = createChartColumn(data: ["Standart", "XXXS", "XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL"], bgColor: .lightGray.withAlphaComponent(0.5))
        let itColumn = createChartColumn(data: ["IT", "36", "38", "40", "42", "44", "46", "48", "50", "52"], bgColor: .white)
        let frColumn = createChartColumn(data: ["FR", "32", "34", "36", "38", "40", "42", "44", "46", "48"], bgColor: .white)
        let usColumn = createChartColumn(data: ["US", "0", "2", "4", "6", "8", "10", "12", "14", "16"], bgColor: .white)
        let ukColumn = createChartColumn(data: ["UK", "4", "6", "8", "10", "12", "14", "16", "18", "20"], bgColor: .white)
        let jpColumn = createChartColumn(data: ["JP", "3", "5", "7", "9", "11", "13", "15", "17", "19"], bgColor: .white)
        addVerticalBorder(to: chart)
        chart.addArrangedSubview(standartColumn)
        addVerticalBorder(to: chart)
        chart.addArrangedSubview(itColumn)
        addVerticalBorder(to: chart)
        chart.addArrangedSubview(frColumn)
        addVerticalBorder(to: chart)
        chart.addArrangedSubview(usColumn)
        addVerticalBorder(to: chart)
        chart.addArrangedSubview(ukColumn)
        addVerticalBorder(to: chart)
        chart.addArrangedSubview(jpColumn)
        addVerticalBorder(to: chart)

        return chart
    }
    
    func createChartColumn(data: [String], bgColor: UIColor) -> UIStackView {
        let column = UIStackView()
        column.translatesAutoresizingMaskIntoConstraints = false
        column.axis = .vertical
        column.alignment  = .center
        column.backgroundColor = bgColor

        //add data
        data.forEach { string in
            addHorizontalBorder(to: column, width: string == data.first ? 1 : 0.5)
            let label = createChartLabel(string: string)
            column.addArrangedSubview(label)
            addHorizontalBorder(to: column, width: string == data.last ? 1 : 0.5)
        }
        
        return column
    }
    
    func createChartLabel(string: String) -> UILabel{
        let title = NSAttributedString(
            string: string,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        let titleLabel = PaddingLabel()
        titleLabel.topInset = 10
        titleLabel.bottomInset = 10
        titleLabel.leftInset = 16
        titleLabel.rightInset = 16
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = title
        
        return titleLabel
    }
    
    func addHorizontalBorder(to stack: UIStackView, width: CGFloat){
        let separator = UIView()
        separator.backgroundColor = .lightGray.withAlphaComponent(0.5)
        stack.addArrangedSubview(separator)
        separator.heightAnchor.constraint(equalToConstant: width).isActive = true
        separator.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
    }
    
    func addVerticalBorder(to stack: UIStackView){
        let separator = UIView()
        separator.backgroundColor = .lightGray.withAlphaComponent(0.5)
        stack.addArrangedSubview(separator)
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive = true
    }
}

//MARK: Business Logic
extension SizeChartViewController {
    func iconPressed(title: String){
        showChart[title]!.toggle()
        removeUI()
        createUI()
    }
}
