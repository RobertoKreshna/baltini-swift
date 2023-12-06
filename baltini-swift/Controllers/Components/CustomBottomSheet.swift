//
//  CustomBottomSheet.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 03/11/23.
//

import UIKit
import RangeSeekSlider

class CustomBottomSheet {
    static private func createGrayIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.brandGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    static private func createDescription(string: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedLabelText = NSAttributedString(
            string: string,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 18)!, .foregroundColor : UIColor.black]
        )
        label.attributedText = attributedLabelText
        label.textAlignment = .left
        return label
    }
    
    static private func createSortRadioButton(title: String, selected: Bool, pressed: UIAction) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setImage(UIImage(named: selected ? "icRadioSelected" : "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentHorizontalAlignment = .left
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0)
        configuration.imagePadding = 12
        button.configuration = configuration
        
        button.addAction(pressed, for: .touchUpInside)
        
        return button
    }
    
    static func createSortContent(selected: String, tapped: @escaping (String) -> Void , close: @escaping () -> Void) -> UIView {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        let indicator = createGrayIndicator()
        let description = createDescription(string: "SORT PRODUCTS")
        let bestButton = createSortRadioButton(
            title: "Best Selling",
            selected: selected == "Best Selling" ? true : false,
            pressed: UIAction(handler: { action in tapped("Best Selling") })
        )
        let featuredButton = createSortRadioButton(
            title: "Featured",
            selected: selected == "Featured" ? true : false,
            pressed: UIAction(handler: { action in tapped("Featured") })
        )
        let lowPriceButton = createSortRadioButton(
            title: "Lowest Price", 
            selected: selected == "Lowest Price" ? true : false,
            pressed: UIAction(handler: { action in tapped("Lowest Price") })
        )
        let highPriceButton = createSortRadioButton(
            title: "Highest Price", 
            selected: selected == "Highest Price" ? true : false,
            pressed: UIAction(handler: { action in tapped("Highest Price") })
        )
        let aToZButton = createSortRadioButton(
            title: "Alphabetically, A-Z", 
            selected: selected == "Alphabetically, A-Z" ? true : false,
            pressed: UIAction(handler: { action in tapped("Alphabetically, A-Z") })
        )
        let zToAButton = createSortRadioButton(
            title: "Alphabetically, Z-A",
            selected: selected == "Alphabetically, Z-A" ? true : false,
            pressed: UIAction(handler: { action in tapped("Alphabetically, Z-A") })
        )
        let newToOldButton = createSortRadioButton(
            title: "Date, New to Old", 
            selected: selected == "Date, New to Old" ? true : false,
            pressed: UIAction(handler: { action in tapped("Date, New to Old") })
        )
        let oldToNewButton = createSortRadioButton(
            title: "Date, Old to New", 
            selected: selected == "Date, Old to New" ? true : false,
            pressed: UIAction(handler: { action in tapped("Date, Old to New") })
        )
        contentView.addArrangedSubview(indicator)
        contentView.setCustomSpacing(12, after: indicator)
        indicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        contentView.addArrangedSubview(description)
        description.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        description.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(bestButton)
        bestButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bestButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(featuredButton)
        featuredButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        featuredButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(lowPriceButton)
        lowPriceButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        lowPriceButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(highPriceButton)
        highPriceButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        highPriceButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(aToZButton)
        aToZButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        aToZButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(zToAButton)
        zToAButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        zToAButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(newToOldButton)
        newToOldButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        newToOldButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        contentView.addArrangedSubview(oldToNewButton)
        oldToNewButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        oldToNewButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        return contentView
    }
    
    static private func createFilterTile(title: String, value: [String], tapped: UITapGestureRecognizer, isRange: Bool) -> UIView {
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        let attributedSubtitle = NSAttributedString(
            string: value.joined(separator: isRange ? " - " : ", "),
            attributes: [.font: UIFont(name: "Futura-Medium", size: 10)!, .foregroundColor : UIColor.black.withAlphaComponent(0.5)]
        )
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = attributedTitle
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.attributedText = attributedSubtitle
        
        let tileStack = UIStackView()
        tileStack.axis = .horizontal
        tileStack.translatesAutoresizingMaskIntoConstraints = false
        
        let checkBox = UIImageView(image: UIImage(named: value.isEmpty ? "icCheck" : "icCheckSelected"))
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStack = UIStackView(arrangedSubviews: value.isEmpty ? [titleLabel] : [titleLabel, valueLabel])
        labelStack.axis = .vertical
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        let rightArrow = UIImageView(image: UIImage(named: "icRight"))
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        
        tileStack.addArrangedSubview(checkBox)
        tileStack.setCustomSpacing(12, after: checkBox)
        tileStack.addArrangedSubview(labelStack)
        tileStack.addArrangedSubview(rightArrow)
        
        checkBox.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 24).isActive = true
        labelStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        rightArrow.widthAnchor.constraint(equalToConstant: 24).isActive = true
        rightArrow.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        tileStack.isLayoutMarginsRelativeArrangement = true
        tileStack.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        tileStack.addGestureRecognizer(tapped)
        
        return tileStack
    }
    
    static func createFilterContent(keys: [String], values:[[String]], tapped: [UITapGestureRecognizer], close: @escaping () -> Void) -> UIView {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let indicator = createGrayIndicator()
        let description = createDescription(string: "FILTER")
        let gender = createFilterTile(title: keys[0], value: values[0], tapped: tapped[0], isRange: false)
        let category = createFilterTile(title: keys[1], value: values[1], tapped: tapped[1], isRange: false)
        let productType = createFilterTile(title: keys[2], value: values[2], tapped: tapped[2], isRange: false)
        let designer = createFilterTile(title: keys[3], value: values[3], tapped: tapped[3], isRange: false)
        let size = createFilterTile(title: keys[4], value: values[4], tapped: tapped[4], isRange: false)
        let price = createFilterTile(title: keys[5], value: values[5], tapped: tapped[5], isRange: true)
        let button = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in close() }))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addArrangedSubview(indicator)
        contentView.addArrangedSubview(description)
        contentView.addArrangedSubview(gender)
        contentView.addArrangedSubview(category)
        contentView.addArrangedSubview(productType)
        contentView.addArrangedSubview(designer)
        contentView.addArrangedSubview(size)
        contentView.addArrangedSubview(price)
        contentView.addArrangedSubview(button)
        
        indicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        description.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        description.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        gender.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        gender.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        category.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        category.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        productType.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        productType.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        designer.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        designer.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        size.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        size.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        price.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        price.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        return contentView
    }
    
    static func createPriceFilterContent(owner: RangeSeekSliderDelegate, minLabel: UILabel, maxLabel: UILabel, close: @escaping () -> Void) -> UIView {
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
            SortFilterValue.shared.addFilterTo(key: "Price", value: [minLabel.text!, maxLabel.text!])
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
    
    static private func createSlider(min: CGFloat, max: CGFloat, minLabel: UILabel, maxLabel: UILabel, owner: RangeSeekSliderDelegate) -> RangeSeekSlider {
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
    
    static private func createPriceStack(priceLabel: UILabel) -> UIStackView {
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
    
    static func createCheckboxListFilterContent(title: String, data: [String], selectedData: [String], close: @escaping () -> Void) -> UIView {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let indicator = createGrayIndicator()
        let backButton = BackButton.createBackButton(title: title, icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            close()
        }))
        
        contentView.addArrangedSubview(indicator)
        contentView.setCustomSpacing(12, after: indicator)
        contentView.addArrangedSubview(backButton)
        contentView.setCustomSpacing(12, after: backButton)
        
        indicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        backButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        var allTiles = [UIStackView]()
        data.forEach({ current in
            let tile = createSizeFilterRow(size: current, selected: selectedData.contains(current))
            contentView.addArrangedSubview(tile)
            allTiles.append(tile)
            tile.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            tile.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        })
        
        contentView.setCustomSpacing(24, after: contentView.arrangedSubviews.last!)
        
        let button = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in
            var res = [String]()
            allTiles.forEach { tile in
                let imageView = tile.arrangedSubviews[0] as! UIImageView
                let label = tile.arrangedSubviews[1] as! UILabel
                if imageView.image == UIImage(named: "icCheckSelected") { res.append(label.text!) }
            }
            SortFilterValue.shared.addFilterTo(key: "Size", value: res)
            close()
        }))
        
        contentView.addArrangedSubview(button)
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        return contentView
    }
    
    static private func createSizeFilterRow(size: String, selected: Bool) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        
        let checkbox = UIImageView(image: UIImage(named: selected ? "icCheckSelected" : "icCheck"))
        checkbox.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let label = UILabel()
        label.text = size
        label.font = UIFont(name: "Futura-Medium", size: 14)
        
        row.addArrangedSubview(checkbox)
        row.setCustomSpacing(12, after: checkbox)
        row.addArrangedSubview(label)
        
        row.isLayoutMarginsRelativeArrangement = true
        row.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        row.addGestureRecognizer(FilterRowTapped(target: self, action: #selector(filterRowTapped(_:)), imageView: checkbox))
        
        return row
    }
    
    @objc static private func filterRowTapped(_ recognizer: FilterRowTapped) {
        DispatchQueue.main.async {
            if recognizer.imageView.image == UIImage(named: "icCheck") {
                recognizer.imageView.image = UIImage(named: "icCheckSelected")
            } else {
                recognizer.imageView.image = UIImage(named: "icCheck")
            }
        }
    }
}
