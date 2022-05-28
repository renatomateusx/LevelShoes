//
//  ProductTableViewCell.swift
//  LevelShoes
//
//  Created by Renato Mateus on 28/05/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var mainImageView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productModelLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var removeActionView: UIView!
    
    static let identifier: String = "ProductTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        
    }
    
    func setupData(with product: Product?) {
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
