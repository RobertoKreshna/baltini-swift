//
//  PriceFilterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 01/12/23.
//
import UIKit
import RangeSeekSlider

class PriceFilterViewController : UIViewController {
    let minLabel: UILabel = {
        let minLabel = UILabel()
        minLabel.font = UIFont(name: "Futura-Medium", size: 16)
        minLabel.textColor = .black.withAlphaComponent(0.5)
        minLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return minLabel
    }()
    let maxLabel: UILabel = {
        let maxLabel = UILabel()
        maxLabel.font = UIFont(name: "Futura-Medium", size: 16)
        maxLabel.textColor = .black.withAlphaComponent(0.5)
        maxLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return maxLabel
    }()
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
extension PriceFilterViewController {
    func createUI(){
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height * 0.35) + 32)
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        if SortFilterValue.shared.getFilterDictValues().last!.isEmpty {
            minLabel.text = "72.00"
            maxLabel.text = "2096.00"
        } else {
            minLabel.text = SortFilterValue.shared.getFilterDictValues().last![0]
            maxLabel.text = SortFilterValue.shared.getFilterDictValues().last![1]
        }
        
        let contentView = createPriceFilterContent(
            owner: self,
            minLabel: minLabel,
            maxLabel: maxLabel,
            close: {
                self.navigationController?.popViewController(animated: true)
            }
        )
        view.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
    }
    
    
    func createPriceFilterContent(owner: RangeSeekSliderDelegate, minLabel: UILabel, maxLabel: UILabel, close: @escaping () -> Void) -> UIView {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let indicator = createGrayIndicator()
        let backButton = BackButton.createBackButton(title: "FILTER - PRICE", icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            close()
        }))
        //row
        let minStack = createPriceStack(priceLabel: minLabel)
        let maxStack = createPriceStack(priceLabel: maxLabel)
        
        let tillLabel = UILabel()
        tillLabel.text = "-"
        tillLabel.font = UIFont(name: "Futura-Medium", size: 16)
        tillLabel.textColor = .black
        tillLabel.textAlignment = .center
        tillLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.spacing = 16
        row.addArrangedSubview(minStack)
        row.addArrangedSubview(tillLabel)
        row.addArrangedSubview(maxStack)
        
        minStack.widthAnchor.constraint(equalTo: maxStack.widthAnchor).isActive = true
        
        //slider
        let cgFloatMin = CGFloat((minLabel.text! as NSString).doubleValue)
        let cgFloatMax = CGFloat((maxLabel.text! as NSString).doubleValue)
        let slider = createSlider(min: cgFloatMin, max: cgFloatMax, minLabel: minLabel, maxLabel: maxLabel, owner: owner)
        //button
        let filterButton = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in
            SortFilterValue.shared.addFilterTo(key: "Price", value: [minLabel.text!, maxLabel.text!], replace: true)
            close()
        }))
        
        contentView.addArrangedSubview(indicator)
        contentView.setCustomSpacing(12, after: indicator)
        contentView.addArrangedSubview(backButton)
        contentView.setCustomSpacing(34, after: backButton)
        contentView.addArrangedSubview(row)
        contentView.setCustomSpacing(37, after: row)
        contentView.addArrangedSubview(slider)
        contentView.setCustomSpacing(40, after: slider)
        contentView.addArrangedSubview(filterButton)
        
        indicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        backButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        row.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        row.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        slider.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        slider.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filterButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filterButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        return contentView
    }
    
    private func createSlider(min: CGFloat, max: CGFloat, minLabel: UILabel, maxLabel: UILabel, owner: RangeSeekSliderDelegate) -> RangeSeekSlider {
        let slider = RangeSeekSlider()
        //min max
        slider.minValue = 72
        slider.selectedMinValue = min
        slider.maxValue = 2096
        slider.selectedMaxValue = max
        slider.minDistance = 50
        slider.step = 1
        //label
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        slider.numberFormatter = formatter
        slider.minLabelFont = UIFont(name: "Futura-Medium", size: 14)!
        slider.minLabelColor = .black
        slider.maxLabelFont = UIFont(name: "Futura-Medium", size: 14)!
        slider.maxLabelColor = .black
        //ui
        slider.handleImage = UIImage(named: "icSlider")
        slider.tintColor = .black.withAlphaComponent(0.5)
        slider.colorBetweenHandles = .black
        slider.delegate = owner
        
        return slider
    }
    
    private func createPriceStack(priceLabel: UILabel) -> UIStackView {
        let column = UIStackView()
        column.translatesAutoresizingMaskIntoConstraints = false
        column.axis = .vertical
        
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        
        let currencyLabel = UILabel()
        currencyLabel.text = "$"
        currencyLabel.font = UIFont(name: "Futura-Medium", size: 16)
        currencyLabel.textColor = .black
        currencyLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        row.addArrangedSubview(currencyLabel)
        row.addArrangedSubview(priceLabel)
        
        let border = CustomSeparator.createHorizontalLine(width: 1, color: .brandGray)
        
        column.addArrangedSubview(row)
        column.setCustomSpacing(4, after: row)
        column.addArrangedSubview(border)
        
        border.leftAnchor.constraint(equalTo: column.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo: column.rightAnchor).isActive = true
        
        return column
    }
    
    private func createGrayIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.brandGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
}



//MARK: Slider delegate
extension PriceFilterViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        let minString = String(String(format: "$%.2f", minValue).dropFirst())
        let maxString = String(String(format: "$%.2f", maxValue).dropFirst())
        DispatchQueue.main.async {
            self.minLabel.text = minString
            self.maxLabel.text = maxString
        }
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        return String(format: "$%.2f", minValue)
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        return String(format: "$%.2f", maxValue)
    }
}
