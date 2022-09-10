//
//  HomePresenter.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import Foundation

protocol HomeViewProtocol: NSObjectProtocol {
    func fetchPictureDidEnd(picture: Picture)
    func fetchPictureWillStart()
}

protocol HomePresenterDelegate: NSObjectProtocol {
    func isFavourite()
    func isNotFavourite()
}


class HomePresenter {
    
    private let service: HomeService
    weak private var homeViewProtocol: HomeViewProtocol?
    weak var delegate: HomePresenterDelegate?
    var picture: Picture? = nil
    
    init(service: HomeService = HomeService()) {
        self.service = service
    }
    
    func attachView(view: HomeViewProtocol) {
        homeViewProtocol = view
    }
    
    func fetchPicture(for date: Date? = nil) {
        homeViewProtocol?.fetchPictureWillStart()
        service.fetchPicture(for: getRequestUrl(for: date)) { [weak self] picture in
            self?.picture = picture
            self?.homeViewProtocol?.fetchPictureDidEnd(picture: picture)
        } onFailure: { errorMessage in
            
        }
    }
    
    func getRequestUrl(for date:Date?) -> URL? {
        var urlComponents = URLComponents(string: NetworkConstants.baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: NetworkConstants.apiKey),
        ]
        
        if let date = date {
            urlComponents?.queryItems?.append(URLQueryItem(name: "date", value: date.dateString()))
        }
        return urlComponents?.url
    }
    
    func isFavourite() -> Bool{
        guard let picture = picture else {
            return false
        }
        return Storage().isFavourite(picture)
    }
    
    func refreshFavouriteIcon() {
        switch isFavourite() {
        case true:
            delegate?.isFavourite()
        default:
            delegate?.isNotFavourite()
        }
    }
    
    func favouriteDidTap() {
        switch isFavourite() {
        case true:
            delegate?.isNotFavourite()
            Storage().deleteFromFavourites(picture?.hdurl)
        default:
            delegate?.isFavourite()
            if let picture = picture {
                Storage().addToFavourites(picture)
            }
        }
    }
}
