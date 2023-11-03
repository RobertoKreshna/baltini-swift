//
//  ViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 23/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
extension HomeViewController {
    
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
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        CustomBanner.addPromotionBanner(to: stackView)
        CustomBanner.addCollectionBanner(to: stackView, tap: UITapGestureRecognizer(target: self, action: #selector(goToList)))
        CustomBanner.addGenderBanner(to: stackView)
        CustomBanner.addSpotlightBanner(to: stackView, using: "spotlightBanner1")
        CustomBanner.addSpotlightBanner(to: stackView, using: "spotlightBanner2")
        CustomBanner.addSpotlightBanner(to: stackView, using: "spotlightBanner3")
        addNewArrival(to: stackView)
        addExcPieces(to: stackView)
        addMagazineStack(to: stackView)
    }
    
    func addNewArrival(to stack: UIStackView){
        stack.setCustomSpacing(40, after: stack.arrangedSubviews.last!)
        
        let newArrivalStack = UIStackView()
        newArrivalStack.axis = .vertical
        newArrivalStack.spacing = 8
        newArrivalStack.alignment = .center
        
        let newArrivalLabel = UILabel()
        newArrivalLabel.attributedText = NSAttributedString(
            string: "NEW ARRIVAL",
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 18)!,
            ]
        )
        
        let newArrivalButton = UIButton()
        newArrivalButton.setAttributedTitle(
            NSAttributedString(
                string: "VIEW ALL",
                attributes: [
                    .font : UIFont(name: "Futura-Medium", size: 12)!,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
            ),
            for: .normal
        )
        
        newArrivalStack.addArrangedSubview(newArrivalLabel)
        newArrivalStack.addArrangedSubview(newArrivalButton)
        addNewArrivalItemStack(to: newArrivalStack, itemLeft: Constants.productData[0], itemRight: Constants.productData[1])
        addNewArrivalItemStack(to: newArrivalStack, itemLeft: Constants.productData[2], itemRight: Constants.productData[3])
        addNewArrivalItemStack(to: newArrivalStack, itemLeft: Constants.productData[4], itemRight: Constants.productData[5])
        
        stack.addArrangedSubview(newArrivalStack)
        
        newArrivalStack.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        newArrivalStack.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
    
    func addNewArrivalItemStack(to stack: UIStackView, itemLeft: Product, itemRight: Product){
        let itemStack = UIStackView()
        itemStack.axis = .horizontal
        itemStack.spacing = 16
        itemStack.translatesAutoresizingMaskIntoConstraints = false
        itemStack.distribution = .fillEqually
        
        addIndividualItemStack(to: itemStack, item: itemLeft)
        addIndividualItemStack(to: itemStack, item: itemRight)
        
        stack.addArrangedSubview(itemStack)
        
        itemStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
    
    func addIndividualItemStack(to stack: UIStackView, item: Product){
        let itemCard = CustomCard.createItemCard(product: item, loadImage: false)
        itemCard.heightAnchor.constraint(equalToConstant: 345).isActive = true
        stack.addArrangedSubview(itemCard)
    }
    
    
    func addExcPieces(to stack: UIStackView){
        stack.setCustomSpacing(40, after: stack.arrangedSubviews.last!)
        
        let excPiecesStack = UIStackView()
        excPiecesStack.axis = .vertical
        excPiecesStack.alignment = .center
        excPiecesStack.translatesAutoresizingMaskIntoConstraints = false
        
        let excPiecesLabel = UILabel()
        excPiecesLabel.attributedText = NSAttributedString(
            string: "EXCLUSIVE PIECES",
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 18)!,
            ]
        )
        
        excPiecesStack.addArrangedSubview(excPiecesLabel)
        excPiecesStack.setCustomSpacing(24, after: excPiecesLabel)
        addBrandExclusive(to: excPiecesStack, brand: Constants.brandData[0])
        addBrandExclusive(to: excPiecesStack, brand: Constants.brandData[1])
        addBrandExclusive(to: excPiecesStack, brand: Constants.brandData[2])
        
        stack.addArrangedSubview(excPiecesStack)
        
        excPiecesStack.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        excPiecesStack.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
    
    func addBrandExclusive(to stack: UIStackView, brand: ExclusiveBrand){
        let brandStack = UIStackView()
        brandStack.axis = .vertical
        
        let brandImageView = UIImageView(image: UIImage(named: brand.imageName))
        
        brandStack.addArrangedSubview(brandImageView)
        brandStack.setCustomSpacing(20, after: brandImageView)
        
        let brandNameLabel = UILabel()
        brandNameLabel.attributedText = NSAttributedString(
            string: brand.name.uppercased(),
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
            ]
        )
        
        brandStack.addArrangedSubview(brandNameLabel)
        brandStack.setCustomSpacing(8, after: brandNameLabel)
        
        let brandDescLabel = UILabel()
        brandDescLabel.attributedText = NSAttributedString(
            string: brand.desc,
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
                .foregroundColor : UIColor.black.withAlphaComponent(0.5),
            ]
        )
        brandDescLabel.numberOfLines = 5
        
        brandStack.addArrangedSubview(brandDescLabel)
        
        stack.addArrangedSubview(brandStack)
        stack.setCustomSpacing(40, after: brandStack)
        
        brandStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
    
    func addMagazineStack(to stack: UIStackView){
        let magazineStack = UIStackView()
        magazineStack.axis = .vertical
        magazineStack.alignment = .center
        
        let magazineLabel = UILabel()
        magazineLabel.attributedText = NSAttributedString(
            string: "MAGAZINE",
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 18)!,
            ]
        )
        
        let magazineButton = UIButton()
        magazineButton.setAttributedTitle(
            NSAttributedString(
                string: "VIEW ALL",
                attributes: [
                    .font : UIFont(name: "Futura-Medium", size: 12)!,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
            ),
            for: .normal
        )
        
        magazineStack.addArrangedSubview(magazineLabel)
        magazineStack.addArrangedSubview(magazineButton)
        addIndividualMagazineStack(to: magazineStack, magazine: Constants.magazinesData[0])
        addIndividualMagazineStack(to: magazineStack, magazine: Constants.magazinesData[1])
        addIndividualMagazineStack(to: magazineStack, magazine: Constants.magazinesData[2])
        addIndividualMagazineStack(to: magazineStack, magazine: Constants.magazinesData[3])
        
        stack.addArrangedSubview(magazineStack)
        
        magazineStack.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        magazineStack.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
    
    func addIndividualMagazineStack(to stack: UIStackView, magazine: Magazine){
        stack.setCustomSpacing(16, after: stack.arrangedSubviews.last!)
        
        let individualMagazineStack = UIStackView()
        individualMagazineStack.axis = .horizontal
        
        let magazineImageView = UIImageView(image: UIImage(named: magazine.imageName))
        magazineImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let magazineDetailStack = UIStackView()
        magazineDetailStack.axis = .vertical
        magazineDetailStack.distribution = .fill
        magazineDetailStack.alignment = .fill
        magazineDetailStack.translatesAutoresizingMaskIntoConstraints = false
        
        let magazineDate = UILabel()
        magazineDate.attributedText = NSAttributedString(
            string: magazine.date,
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 12)!,
                .foregroundColor : UIColor.black.withAlphaComponent(0.5)
            ]
        )
        magazineDate.setContentHuggingPriority(.required, for: .vertical)

        let magazineTitle = UILabel()
        magazineTitle.attributedText = NSAttributedString(
            string: magazine.title,
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
            ]
        )
        magazineTitle.numberOfLines = 0
        
        magazineDetailStack.addArrangedSubview(magazineDate)
        magazineDetailStack.addArrangedSubview(magazineTitle)
        
        individualMagazineStack.addArrangedSubview(magazineImageView)
        individualMagazineStack.setCustomSpacing(12, after: magazineImageView)
        individualMagazineStack.addArrangedSubview(magazineDetailStack)
        
        
        magazineImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        magazineImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stack.addArrangedSubview(individualMagazineStack)
        
        individualMagazineStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
}

//Business Logic

extension HomeViewController {
    @objc func goToList(){
        self.navigationController?.pushViewController(ProductListViewController(), animated: true)
    }
}

