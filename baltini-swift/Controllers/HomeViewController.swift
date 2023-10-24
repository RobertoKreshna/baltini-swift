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
        createUI()
    }
}


//MARK: Create UI Methods
extension HomeViewController {
    
    func createUI(){
        //create scroll view
        let scrollView = UIScrollView()
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
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        addCollectionBanner(to: stackView)
        addGenderBanner(to: stackView)
        addSpotlightBanner(to: stackView, using: "spotlightBanner1")
        addSpotlightBanner(to: stackView, using: "spotlightBanner2")
        addSpotlightBanner(to: stackView, using: "spotlightBanner3")
        addNewArrival(to: stackView)
        addExcPieces(to: stackView)
        addMagazineStack(to: stackView)
    }
    
    func addCollectionBanner(to stack: UIStackView){
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collectionBanner")
        
        stack.addArrangedSubview(imageView)
        
        imageView.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
    
    func addGenderBanner(to stack: UIStackView){
        let genderStack = UIStackView()
        genderStack.axis = .horizontal
        genderStack.spacing = 16
        genderStack.translatesAutoresizingMaskIntoConstraints = false
        genderStack.distribution = .fillEqually
        
        let menBannerView = UIImageView()
        menBannerView.image = UIImage(named: "menBanner")
        let womenBannerView = UIImageView()
        womenBannerView.image = UIImage(named: "womenBanner")
        
        genderStack.addArrangedSubview(menBannerView)
        genderStack.addArrangedSubview(womenBannerView)
        
        stack.addArrangedSubview(genderStack)
        stack.setCustomSpacing(24, after: genderStack)
        
        genderStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
    
    func addSpotlightBanner(to stack: UIStackView, using imageName: String){
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        
        stack.addArrangedSubview(imageView)
        
        imageView.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
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
        addNewArrivalItemStack(to: newArrivalStack, itemLeft: const.productData[0], itemRight: const.productData[1])
        addNewArrivalItemStack(to: newArrivalStack, itemLeft: const.productData[2], itemRight: const.productData[3])
        addNewArrivalItemStack(to: newArrivalStack, itemLeft: const.productData[4], itemRight: const.productData[5])
        
        stack.addArrangedSubview(newArrivalStack)
        
        newArrivalStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
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
        let individualItemStack = UIStackView()
        individualItemStack.axis = .vertical
        individualItemStack.spacing = 4
        individualItemStack.alignment = .center
        
        let itemImageView = UIImageView()
        itemImageView.image = UIImage(named: item.imageName)
        
        let itemBrandLabel = UILabel()
        itemBrandLabel.attributedText = NSAttributedString(
            string: item.brand.uppercased(),
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
            ]
        )
        
        let itemNameLabel = UILabel()
        itemNameLabel.attributedText = NSAttributedString(
            string: item.name,
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
                .foregroundColor : UIColor.black.withAlphaComponent(0.5)
            ]
        )
        itemNameLabel.numberOfLines = 3
        itemNameLabel.textAlignment = .center
        
        individualItemStack.addArrangedSubview(itemImageView)
        individualItemStack.addArrangedSubview(itemBrandLabel)
        individualItemStack.addArrangedSubview(itemNameLabel)
        addPriceStack(to: individualItemStack, item: item)
        
        itemImageView.heightAnchor.constraint(equalToConstant: 245).isActive = true
        
        stack.addArrangedSubview(individualItemStack)
    }
    
    func addPriceStack(to stack: UIStackView, item: Product){
        let priceStack = UIStackView()
        priceStack.axis = .horizontal
        priceStack.spacing = 4
        
        let itemPriceLabel = UILabel()
        itemPriceLabel.attributedText = NSAttributedString(
            string: String(format: "$%.2f", item.price),
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
                .foregroundColor : UIColor.black.withAlphaComponent(0.5),
                .strikethroughStyle : item.isDisc ? 1 : 0,
            ]
        )
        
        priceStack.addArrangedSubview(itemPriceLabel)
        
        if(item.isDisc == true){
            let itemDiscPriceLabel = UILabel()
            itemDiscPriceLabel.attributedText = NSAttributedString(
                string: String(format: "$%.2f", item.discPrice!),
                attributes: [
                    .font : UIFont(name: "Futura-Medium", size: 14)!,
                    .foregroundColor : UIColor.brandRed
                ]
            )
            priceStack.addArrangedSubview(itemDiscPriceLabel)
        }
        
        stack.addArrangedSubview(priceStack)
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
        addBrandExclusive(to: excPiecesStack, brand: const.brandData[0])
        addBrandExclusive(to: excPiecesStack, brand: const.brandData[1])
        addBrandExclusive(to: excPiecesStack, brand: const.brandData[2])
        
        stack.addArrangedSubview(excPiecesStack)
        
        excPiecesStack.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
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
        addIndividualMagazineStack(to: magazineStack, magazine: const.magazinesData[0])
        addIndividualMagazineStack(to: magazineStack, magazine: const.magazinesData[1])
        addIndividualMagazineStack(to: magazineStack, magazine: const.magazinesData[2])
        addIndividualMagazineStack(to: magazineStack, magazine: const.magazinesData[3])
        
        stack.addArrangedSubview(magazineStack)
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

