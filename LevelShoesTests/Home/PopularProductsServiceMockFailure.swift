//
//  PopularProductsServiceMockFailure.swift
//  LevelShoesTests
//
//  Created by Renato Mateus on 27/05/22.
//

import Foundation
@testable import LevelShoes

class PopularProductsServiceMockFailure: PopularProductsServiceProtocol {
    func fetchData(completion: @escaping (Result<DataProducts, Error>) -> Void) {
        completion(.failure(NSError(domain: "No data was downloaded.",
                                    code: 400,
                                    userInfo: nil)))
    }
}
