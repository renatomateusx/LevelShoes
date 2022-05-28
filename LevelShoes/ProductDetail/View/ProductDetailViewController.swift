//
//  ProductDetailViewController.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailContentView: UIView!
    @IBOutlet weak var productBadgesLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productModel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addToBag: UIButton!
    
    // MARK: - Private Properties
    private let viewModel = ProductDetailViewModel()
    private let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let product: Product
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        configureCartButton()
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Inits
    init(with product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension ProductDetailViewController {
    private func configureBackButton() {
        self.backButton.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func configureCartButton() {
        self.addToBag.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    /// This action could be inserted in viewModel and trigger the viewController again to show the alert.
    @objc func addToCart(_ sender: UIButton) {
        if Utilis.addToCart(product: self.product) {
            showAlert(title: "Wow!", message: "Added to cart!")
        } else {
            showAlert(title: "Oops!", message: "You already have this product in cart.")
        }
    }
}

extension ProductDetailViewController {
    func setupUI() {
        self.spinner.hidesWhenStopped = true
        self.detailContentView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        showLoading()
    }
    
    func showLoading() {
        self.spinner.startAnimating()
    }
    
    func hideLoading() {
        self.spinner.stopAnimating()
    }
    
    func setupData() {
        showLoading()
        DispatchQueue.main.async {
            self.productModel.text = self.product.name
            self.productBrandLabel.text = self.product.brand
            self.productBadgesLabel.text = Utilis.getBadges(self.product.badges)
            self.price.text = Utilis.getPrice(price: self.product.price)
            if let originalPrice = self.product.originalPrice {
                self.originalPrice.attributedText = Utilis.getCanceledPrice(priceText: Utilis.getPrice(price: originalPrice))
                self.originalPrice.isHidden = false
            } else {
                self.originalPrice.isHidden = true
            }
            let url = URL(string: self.product.image)
            self.productImageView.kf.setImage(with: url,
                                              placeholder: nil,
                                              options: nil,
                                              progressBlock: nil,
                                              completionHandler: nil)
            
            self.hideLoading()
        }
    }
}


// MARK: - Alert

private extension ProductDetailViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
}
