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
        minLabel.text = "172.00"
        minLabel.font = UIFont(name: "Futura-Medium", size: 16)
        minLabel.textColor = .black.withAlphaComponent(0.5)
        minLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return minLabel
    }()
    let maxLabel: UILabel = {
        let maxLabel = UILabel()
        maxLabel.text = "1996.00"
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
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height * 0.4) + 32)
        view.backgroundColor = .white
        view.clipsToBounds = true
        
        let contentView = CustomBottomSheet.createPriceFilterContent(
            backButtonTapped: UIAction(handler: { action in
                self.navigationController?.popViewController(animated: true)
            }),
            owner: self,
            minLabel: minLabel,
            maxLabel: maxLabel
        )
        view.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
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
