//
//  ProductDetailViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 07/11/23.
//

import UIKit
import HSCycleGalleryView

class ProductDetailViewController : UIViewController {
    var productId: String = ""
    var product: ProductDetail?
    var selectedVariantIndex = 0
    var quantity = 1
    
    lazy var imagePagerControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        Task{
            removeUI()
            await loadData()
            createUI()
        }
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Load data by API
extension ProductDetailViewController {
    func loadData() async {
        let loading = CustomPopup.displayLoading(sender: self)
        if productId.isEmpty == false {
            self.view.addSubview(loading)
            let url = URL(string: "https://baltini-staging.myshopify.com/admin/api/2023-01/products/\(productId).json")!
            var request = URLRequest(url: url)
            request.setValue(Constants.key, forHTTPHeaderField: "X-Shopify-Access-Token")
            do{
                let (data, _) = try await URLSession.shared.data(for: request)
                let json = (try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, Any>)
                product = ProductDetail.fromJson(json: json)
            } catch {
                print("error gettting data")
            }
            loading.removeFromSuperview()
        } else {
            CustomToast.showErrorToast(msg: "Application Error (Dont have any id)", sender: self)
        }
    }
}

//MARK: Create UI Methods

extension ProductDetailViewController {
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
        
        BackButton.addBackButton(to: stackView, title: "\(String(describing: product!.brand)) - \(String(describing: product!.name))", icName: "icBack", sender: self, usePadding: true)
        CustomBanner.addPromotionBanner(to: stackView, spacing: 0)
        
        //add image carousel
        let imageCarouselContainer = UIView()
        imageCarouselContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let pager = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 390))
        pager.register(cellClass: ImageCarouselCell.self, forCellReuseIdentifier: "TestCollectionViewCell")
        pager.delegate = self
        imageCarouselContainer.addSubview(pager)
        pager.reloadData()
        
        stackView.addArrangedSubview(imageCarouselContainer)
        
        imageCarouselContainer.heightAnchor.constraint(equalToConstant: 390).isActive = true
        imageCarouselContainer.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        imageCarouselContainer.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        
        //add indicator
        imagePagerControl.translatesAutoresizingMaskIntoConstraints = false
        imagePagerControl.backgroundStyle = .minimal
        imagePagerControl.numberOfPages = product!.images.count
        
        imagePagerControl.pageIndicatorTintColor = .lightGray
        imagePagerControl.currentPageIndicatorTintColor = .black
        
        stackView.addArrangedSubview(imagePagerControl)
        stackView.setCustomSpacing(32, after: imagePagerControl)
        
        imagePagerControl.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imagePagerControl.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        imagePagerControl.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        
        //add product main content
        let productMain = createProductMainDescriptionStack()
        stackView.addArrangedSubview(productMain)
        
        productMain.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        productMain.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        //add variants
        let variantStack = createVariantStack()
        stackView.addArrangedSubview(variantStack)
        stackView.setCustomSpacing(32, after: variantStack)
        
        variantStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        variantStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        //add quantity
        let quantityStack = createQtyStack()
        stackView.addArrangedSubview(quantityStack)
        stackView.setCustomSpacing(32, after: quantityStack)
        
        quantityStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        quantityStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        //add product detail
        let productDetail = createProductDetailStack()
        stackView.addArrangedSubview(productDetail)
        
        productDetail.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        productDetail.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
    
    func createLabel(content: String, fontsize: CGFloat, textColor: UIColor) -> UILabel {
        let attributedLabelText = NSAttributedString(
            string: content,
            attributes: [.font : UIFont(name: "Futura-Medium", size: fontsize)!, .foregroundColor : textColor]
        )
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedLabelText
        label.numberOfLines = 0
        return label
    }
    
    func createLabelWithAttributedString(content: NSAttributedString) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = content
        label.numberOfLines = 0
        return label
    }
        
    
    func createPriceAlternativeStack(text: UILabel) -> UIStackView{
        let imageView = UIImageView(image: UIImage(named: "afterpay"))
        let alternativePriceStack = UIStackView(arrangedSubviews: [text, imageView])
        alternativePriceStack.spacing = 0
        alternativePriceStack.alignment = .center
        
        return alternativePriceStack
    }
    
    func createProductMainDescriptionStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.alignment = .leading
        
        lazy var brandLabel = createLabel(content: product!.brand, fontsize: 18, textColor: .black)
        lazy var nameLabel = createLabel(content: product!.name, fontsize: 14, textColor: .black)
        lazy var priceLabel = createLabel(content: "$\(product!.price[selectedVariantIndex])", fontsize: 16, textColor: .black.withAlphaComponent(0.5))
        lazy var alternativePriceLabel = createLabel(content: "or 4 interest-free payments of $\(product!.price[selectedVariantIndex] / 4.0) with", fontsize: 12, textColor: .black)
        
        contentStack.addArrangedSubview(brandLabel)
        contentStack.setCustomSpacing(4, after: brandLabel)
        contentStack.addArrangedSubview(nameLabel)
        contentStack.setCustomSpacing(8, after: nameLabel)
        contentStack.addArrangedSubview(priceLabel)
        contentStack.setCustomSpacing(8, after: priceLabel)
        let alternativePriceStack = createPriceAlternativeStack(text: alternativePriceLabel)
        contentStack.addArrangedSubview(alternativePriceStack)
        
        return contentStack
    }
    
    func createVariantStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.alignment = .leading
        
        let titleStack = createVariantTitleStack()
        contentStack.addArrangedSubview(titleStack)
        titleStack.leftAnchor.constraint(equalTo: contentStack.leftAnchor).isActive = true
        titleStack.rightAnchor.constraint(equalTo: contentStack.rightAnchor).isActive = true
        
        let sizesStack = UIStackView()
        sizesStack.spacing = 8
        for i in 0...product!.variants!.count - 1 {
            let button = CustomButton.createSizeButton(
                value: product!.variants![i],
                selected: i == selectedVariantIndex,
                tapped: UIAction(handler: { action in self.selectedVariantIndex = i; self.removeUI(); self.createUI() })
            )
            sizesStack.addArrangedSubview(button)
        }
        contentStack.addArrangedSubview(sizesStack)
        
        return contentStack
    }
    
    func createVariantTitleStack() -> UIStackView {
        let titleStack = UIStackView()
        titleStack.axis = .horizontal
        titleStack.distribution = .equalCentering
        
        let label = createLabel(content: "SIZE", fontsize: 14, textColor: .black)
        let button = CustomButton.createUnderlinedButton(title: "SIZE CHART", action: UIAction(handler: { action in
            self.navigationController?.pushViewController(SizeChartViewController(), animated: true)
        }))
        
        titleStack.addArrangedSubview(label)
        titleStack.addArrangedSubview(button)
        return titleStack
    }
    
    func createQtyStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.alignment = .leading
        
        let titleLabel = createLabel(content: "QUANTITY", fontsize: 14, textColor: .black)
        contentStack.addArrangedSubview(titleLabel)
        
        let qtyButtonStack = createQtyButtonStack()
        contentStack.addArrangedSubview(qtyButtonStack)
        
        return contentStack
    }
    
    func createQtyButtonStack() -> UIStackView{
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        
        let qtyTitle = NSAttributedString(
            string: String(quantity),
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        
        let label = PaddingLabel()
        label.attributedText = qtyTitle
        label.topInset = 10
        label.bottomInset = 10
        label.leftInset = 20
        label.rightInset = 20
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.brandGray.cgColor
        
        let minButton = CustomButton.createQuantityButton(imageName: "icMin", isLeft: true, tapped: UIAction(handler: { action in
            if self.quantity > 1 { self.quantity -= 1 }; DispatchQueue.main.async {
                label.attributedText = NSAttributedString(
                    string: String(self.quantity),
                    attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
                )
            }
        }))
        let plusButton = CustomButton.createQuantityButton(imageName: "icPlus", isLeft: false, tapped: UIAction(handler: { action in
            self.quantity += 1; DispatchQueue.main.async {
                label.attributedText = NSAttributedString(
                    string: String(self.quantity),
                    attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
                )
            }
        }))
        
        buttonStack.addArrangedSubview(minButton)
        buttonStack.addArrangedSubview(label)
        buttonStack.addArrangedSubview(plusButton)
        
        return buttonStack
    }
    
    func createProductDetailStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 8
        
        let label = createLabel(content: "PRODUCT DETAILS", fontsize: 14, textColor: .black)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        let desc =  "Hooded Neck<br>Front Zip Closure<br>Two Side Pocket<br>Unlined inner<br>100% Polyamide<br>Made in Italy<br>Model is 184 cm tall and wear size 48 IT"
        let detailsDesc = createLabelWithAttributedString(content: desc.htmlAttributedString(font: "Futura-Medium", size: 14, color: .black)!)
        let details = createLabelWithAttributedString(content: product!.tags!.htmlAttributedString(font: "Futura-Medium", size: 14, color: .black)!)
        
        contentStack.addArrangedSubview(label)
        contentStack.addArrangedSubview(detailsDesc)
        contentStack.addArrangedSubview(details)
        
        return contentStack
    }
}

//MARK: Carousel Methods
extension ProductDetailViewController : HSCycleGalleryViewDelegate {
    func changePageControl(currentIndex: Int) {
        self.imagePagerControl.currentPage = currentIndex
    }
    
    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        return product!.images.count
    }
    
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "TestCollectionViewCell", for: IndexPath(item: index, section: 0)) as! ImageCarouselCell
        cell.imageView.imageFromServerURL(product!.images[index], placeHolder: UIImage(named: "productPlaceholder"))
        return cell
    }
}
