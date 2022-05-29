//
//  ProductTableViewCell.swift
//  LevelShoes
//
//  Created by Renato Mateus on 28/05/22.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func productRemovedFromWhishList(_ product: Product)
}

class ProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productModelLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var removeActionView: UIButton!
    
    static let identifier: String = "ProductTableViewCell"
    private var product: Product?
    var delegate: ProductTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        self.removeActionView.addTarget(self,
                                        action: #selector(favoriteProduct(_:)),
                                        for: .touchUpInside)
    }
    
    func setupData(with product: Product?) {
        self.product = product
        if let product = product {
            let imagePlaceholder = UIImage(named: "placeholder")
            if let url = URL(string: product.image) {
                self.productImageView.kf.setImage(with: url,
                                                  placeholder: imagePlaceholder,
                                                  options: nil,
                                                  progressBlock: nil,
                                                  completionHandler: nil)
            }
            
            self.productBrandLabel.text = product.brand.uppercased()
            self.productModelLabel.text = product.name.uppercased()
            self.productPriceLabel.text = Utilis.getPrice(price: product.price)
        }
    }
}

private extension ProductTableViewCell {
    @objc func favoriteProduct(_ tapGestureRecognizer: UITapGestureRecognizer) {
        if let product = self.product,
           Utilis.removeFromFavorites(product: product) {
            delegate?.productRemovedFromWhishList(product)
        }
    }
}
