//
//  WishListViewModel.swift
//  LevelShoes
//
//  Created by Renato Mateus on 28/05/22.
//

import Foundation

protocol WishListViewModelDelegate: AnyObject {
    func onSuccessFetchingProducts(products: Products?)
}

class WishListViewModel {
    
    //MARK: - Properties
    var favoriteList: Products?
    
    // MARK: - Private Properties
    let productsService: WishListServiceProtocol
    var delegate: WishListViewModelDelegate?
    // MARK: - Inits
    
    init(with service: WishListServiceProtocol) {
        self.productsService = service
    }
    
    func fetchData() {
        productsService.fetchData() { products in
            self.favoriteList = products
            self.delegate?.onSuccessFetchingProducts(products: products)
        }
    }
    
    func isFavoritedProduct(product: Product) -> Bool {
        if let favorites = favoriteList {
            return (favorites.first(where: { $0.id == product.id }) != nil)
        } else {
            return false
        }
    }
}
