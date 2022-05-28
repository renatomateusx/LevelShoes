//
//  UICollectionView+Extensions.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import UIKit

public extension UICollectionView {
    
    /// Shows project's default loading on the UITableView.
    func showLoading(color: UIColor = UIColor.darkGray) {
        let loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loading.color = color
        loading.startAnimating()
        self.backgroundView = loading
    }
    
    /// Hides any visible loading from the UITableView.
    func hideLoading() {
        self.backgroundView = nil
    }
}
