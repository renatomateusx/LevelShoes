//
//  Utilis.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import UIKit

struct Utilis {
    
    private static let userDefaults = UserDefaults.standard
    
    static func saveToFavorites(product: Product) {
        var decodedProducts: Products = []
        if let products = getFavorites() {
            decodedProducts = products
            if (products.first(where: { $0.id == product.id }) == nil) {
                decodedProducts.append(product)
            }
        } else {
            decodedProducts.append(product)
        }
        
        if let encoded = encodeProducts(products: decodedProducts) {
            userDefaults.set(encoded, forKey: Constants.favoritesKey)
        }
    }
    
    static func getFavorites() -> Products? {
        if let dataProducts = userDefaults.object(forKey: Constants.favoritesKey) as? Data {
            return decodeProducts(products: dataProducts)
        }
        return []
    }
    
    static func removeFromFavorites(product: Product) -> Bool {
        if var favorites = getFavorites() {
            if let productIndexToRemove = favorites.firstIndex(where: { $0.id == product.id }) {
                favorites.remove(at: productIndexToRemove)
                let encodecFavoritesProducts = encodeProducts(products: favorites)
                userDefaults.set(encodecFavoritesProducts, forKey: Constants.favoritesKey)
                return true
            }
        }
        return false
    }
    
    private static func decodeProducts(products: Data) -> Products {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(Products.self, from: products) {
            return decoded
        }
        return []
    }
    
    private static func encodeProducts(products: Products) -> Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            return encoded
        }
        return nil
    }
}

extension Utilis {
    static func getBadges(_ badges: [String]?) -> String {
        var stringBadges = ""
        if let badges = badges {
            stringBadges = badges.joined(separator: " ")
        }
        return stringBadges
    }
    
    static func getPrice(price: Int) -> String {
        let result = NumberFormatter.localizedString(from: price as NSNumber, number: .currency)
        return "\(result) AED"
    }
    
    static func getCanceledPrice(priceText: String) -> NSAttributedString? {
        let attributedText = NSAttributedString(
            string: priceText,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        return attributedText
    }
}

// MARK: Cart
/// I'm used to work with the backend managing the card. We just need to send the product to the BackEnd and the backEnd to the rest.

extension Utilis {
    static func addToCart(product: Product) -> Bool {
        var addedToCart: Bool = false
        if var cart = getCart() {
            if (cart.first(where: { $0.id == product.id }) == nil) {
                cart.append(product)
                updateCart(cart: cart)
                addedToCart = true
            }
        } else {
            updateCart(cart: [product])
            addedToCart = true
        }
        return addedToCart
    }
    
    private static func updateCart(cart: Products) {
        if let encoded = encodeProducts(products: cart) {
            userDefaults.set(encoded, forKey: Constants.cartKey)
        }
    }
    
    private static func getCart() -> Products? {
        if let dataCartProducts = userDefaults.object(forKey: Constants.cartKey) as? Data {
            return decodeProducts(products: dataCartProducts)
        }
        return []
    }
}
