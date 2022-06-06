//
//  ProductsViewCell.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import UIKit

class ProductsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productContentView: UIView!
    @IBOutlet weak var badges: UILabel!
    @IBOutlet weak var bookmarkImageView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    static let identifier: String = "ProductsViewCell"
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension ProductsViewCell {
    func setupUI() {
        productContentView.clipsToBounds = true
        productContentView.layer.masksToBounds = false
//        productContentView.backgroundColor = .clear
    }
    
    func setupData(with product: Product) {
        self.product = product
        let imagePlaceholder = UIImage(named: "placeholder")
        if let url = URL(string: product.image) {
            self.productImageView.kf.setImage(with: url,
                                              placeholder: imagePlaceholder,
                                              options: nil,
                                              progressBlock: nil,
                                              completionHandler: nil)
        }
        if let badges = product.badges, badges.count > 0 {
            self.badges.text = Utilis.getBadges(badges)
            self.badges.isHidden = false
        } else {
            self.badges.isHidden = true
        }
        self.brandLabel.text = product.brand.uppercased()
        self.productTitleLabel.text = product.name.uppercased()
        self.priceLabel.text = Utilis.getPrice(price: product.price)
        if let originalPrice = product.originalPrice {
            self.originalPrice.attributedText = Utilis.getCanceledPrice(priceText: Utilis.getPrice(price: originalPrice))
            self.originalPrice.isHidden = false
        } else {
            self.originalPrice.isHidden = true
        }
        
        if let isFavorite = product.isFavorite, isFavorite {
            self.bookmarkImageView.image = UIImage(named: "taggedMark")
        } else {
            self.bookmarkImageView.image = UIImage(named: "tagMark")
        }
        
        setupFavoriteAction()
    }
    
    
}

// MARK: - Actions

private extension ProductsViewCell {
    private func setupFavoriteAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteProduct))
        self.bookmarkImageView.isUserInteractionEnabled = true
        self.bookmarkImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func favoriteProduct(_ tapGestureRecognizer: UITapGestureRecognizer) {
        if let product = self.product {
            Utilis.saveToFavorites(product: product)
            self.bookmarkImageView.image = UIImage(named: "taggedMark")
        }
    }
}
