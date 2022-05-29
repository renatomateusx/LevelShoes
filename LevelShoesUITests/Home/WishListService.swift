//
//  WishListService.swift
//  LevelShoes
//
//  Created by Renato Mateus on 29/05/22.
//

import Foundation

protocol WishListServiceProtocol: AnyObject {
    func fetchData(completion: @escaping(Products?) -> Void)
}

class WishListService {
}

extension WishListService: WishListServiceProtocol {
    func fetchData(completion: @escaping(Products?) -> Void) {
        let result = Utilis.getFavorites()
        completion(result)
    }
}
