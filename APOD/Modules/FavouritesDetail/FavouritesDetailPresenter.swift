//
//  FavouritesDetailPresenter.swift
//  APOD
//
//  Created by Supreeth Doddabela on 10/09/2022.
//

import Foundation

protocol FavouritesDetailProtocol: NSObjectProtocol {
    func loadView(with pod: POD)
}

protocol FavouritesDetailPresenterDelegate: NSObjectProtocol {
    func isFavourite()
    func isNotFavourite()
}

class FavouritesDetailPresenter{
    var pod: POD? = nil
    weak private var favouritesDetailProtocol: FavouritesDetailProtocol?
    weak var delegate: FavouritesDetailPresenterDelegate?
    var isFavourite: Bool = true
    
    /**
        This function attches the presenter with the view.
        -  FavouritesDetailView is confirmed to FavouritesDetailProtocol
     */
    func attachView(view: FavouritesDetailProtocol) {
        favouritesDetailProtocol = view
        if let pod = pod {
            favouritesDetailProtocol?.loadView(with: pod)
        }
    }
    
    ///This function  is called from Controller when the favourite button is tapped
    func favouriteDidTap() {
        switch isFavourite {
        case true:
            delegate?.isFavourite()
        default:
            delegate?.isNotFavourite()
        }
        isFavourite.toggle()
    }
    
    /**
        This function will be called before FavouriteDetailViewcontroller is popped fro the navigatino stack
         -  If favourite button is selected/filled - Retain the item in the favourites list
         -  If favourite button is not selected - Delete the item from the favourite list
     */
    func willPop(_ isMovingFromParent:Bool) {
        if isMovingFromParent {
            switch isFavourite {
            case false:
                Storage().deleteFromFavourites(pod?.url)
            default:
                break
            }
        }
    }
}
