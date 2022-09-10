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
    
    func attachView(view: FavouritesDetailProtocol) {
        favouritesDetailProtocol = view
        if let pod = pod {
            favouritesDetailProtocol?.loadView(with: pod)
        }
    }
    
    func favouriteDidTap() {
        switch isFavourite {
        case true:
            delegate?.isFavourite()
        default:
            delegate?.isNotFavourite()
        }
        isFavourite.toggle()
    }
    
    func willPop(_ isMovingFromParent:Bool) {
        if isMovingFromParent {
            switch isFavourite {
            case false:
                Storage().deleteFromFavourites(pod?.hdurl)
            default:
                break
            }
        }
    }
}
