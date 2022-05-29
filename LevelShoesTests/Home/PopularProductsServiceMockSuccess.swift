//
//  PopularProductsServiceMockSuccess.swift
//  LevelShoesTests
//
//  Created by Renato Mateus on 27/05/22.
//

import Foundation
@testable import LevelShoes

class PopularProductsServiceMockSuccess: PopularProductsServiceProtocol {
    func fetchData(completion: @escaping (Result<DataProducts, Error>) -> Void) {
        let fakeProducts: DataProducts = DataProducts(title: "Prod 1", currency: "AED", items: [])
        completion(.success(fakeProducts))
    }
}
