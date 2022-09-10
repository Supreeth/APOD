//
//  FavouritesPresenter.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import Foundation

protocol FavouritesProtocol: NSObjectProtocol {
   
}

class FavouritesPresenter {
    weak private var favouriteProtocol: FavouritesProtocol?
    var itemSelected: POD? = nil
    
    func attachView(view: FavouritesProtocol) {
        favouriteProtocol = view
    }
    
    func fetchFavourites() -> [POD]{
        return Storage().fetchFavourites() ?? [POD]()
    }
}
