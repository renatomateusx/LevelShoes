//
//  HomeViewModel.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingProducts(products: DataProducts)
    func onFailureFetchingProducts(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let productsService: PopularProductsServiceProtocol
    var delegate: HomeViewModelDelegate?
    var favoritedProducts = Utilis.getFavorites()
    // MARK: - Inits
    
    init(with service: PopularProductsServiceProtocol) {
        self.productsService = service
    }
    
    func fetchData() {
        productsService.fetchData() { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            
            case .success(let products):
                self.delegate?.onSuccessFetchingProducts(products: products)
            case .failure(let error):
                self.delegate?.onFailureFetchingProducts(error: error)
            }
        }
    }
    
    func isFavoritedProduct(product: Product) -> Bool {
        if let favorites = favoritedProducts {
            return (favorites.first(where: { $0.id == product.id }) != nil)
        } else {
            return false
        }
    }
}
