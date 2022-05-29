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
        let fakeProducts: DataProducts = DataProducts(title: "Prod 1", currency: "AED", items: getProductsMock())
        completion(.success(fakeProducts))
    }
}

extension PopularProductsServiceMockSuccess {
    func getProductsMock() -> Products {
        return [
            Product(id: "1",
                    sku: "OMIA190F21FAB001-1007",
                    image: "https://i.imgur.com/oNo46c2m.jpg",
                    brand: "OFF-WHITE",
                    name: "Odsy-2000 sneakers",
                    price: 2580,
                    originalPrice: 3000,
                    badges: [
                        "NEW",
                        "SALE"
                      ]),
            Product(id: "3",
                    sku: "534968GKQN61070",
                    image: "https://i.imgur.com/4uck7eem.jpg",
                    brand: "SAINT LAURENT",
                    name: "City backpack",
                    price: 4700,
                    originalPrice: 6000,
                    badges: [])
        ]
    }
}
