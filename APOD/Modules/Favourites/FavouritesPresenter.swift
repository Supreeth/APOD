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
    
    /**
        This function attches the presenter with the view.
        -  FavouritesView is confirmed to FavouritesProtocol
     */
    func attachView(view: FavouritesProtocol) {
        favouriteProtocol = view
    }
    
    ///This functions retrieves all the favourites stored in core data
    func fetchFavourites() -> [POD]{
        return Storage().fetchFavourites() ?? [POD]()
    }
}
