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
    
    let imagePagerControl = UIPageControl()
    
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
        
        BackButton.addBackButton(to: stackView, title: "\(String(describing: product!.name))", sender: self)
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
        
        imagePagerControl.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imagePagerControl.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        imagePagerControl.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
    }
}

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
