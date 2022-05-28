//
//  PopularProducts.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import Foundation

typealias Products = [Product]

struct DataProducts: Codable {
    let title: String?
    let currency: String?
    let items: Products?
}

struct Product: Codable {
    let id: String
    let sku: String
    let image: String
    let brand: String
    let name: String
    let price: Int
    let originalPrice: Int?
    let badges: [String]?
    var isFavorite: Bool? = false
}
