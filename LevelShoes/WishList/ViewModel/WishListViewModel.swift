//
//  WishListViewModel.swift
//  LevelShoes
//
//  Created by Renato Mateus on 28/05/22.
//

import Foundation

class WishListViewModel {
    var favoriteList = Utilis.getFavorites()
    
    
    func updateList() {
        favoriteList = Utilis.getFavorites()
    }
}
