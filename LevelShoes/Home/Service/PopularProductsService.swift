//
//  PopularProductsService.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import Foundation

protocol PopularProductsServiceProtocol: AnyObject {
    func fetchData(completion: @escaping(Result<DataProducts, Error>) -> Void)
}

class PopularProductsService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension PopularProductsService: PopularProductsServiceProtocol {
    func fetchData(completion: @escaping(Result<DataProducts, Error>) -> Void) {
        let endpoint = PopularProductsEndpoint()
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
