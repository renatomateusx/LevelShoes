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
    
    // MARK: - Private Properties
    let productsService: WishListServiceProtocol
    var delegate: WishListViewModelDelegate?
    // MARK: - Inits
    
    init(with service: WishListServiceProtocol) {
        self.productsService = service
    }
    
    func fetchData() {
        productsService.fetchData() { [weak self] products in
            guard let self = self else { return }
            self.delegate?.onSuccessFetchingProducts(products: products)
        }
    }
}
