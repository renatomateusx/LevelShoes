//
//  PopularProductsEndPoint.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import Foundation

struct PopularProductsEndpoint {

    var host: String {
        return Constants.productsURL
    }

    var path: String {
        return "v3/5c138271-d8dd-4112-8fb4-3adb1b7f689e"
    }
    
    var url: URL {
        return URL(string: "\(host)\(path)")!
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
