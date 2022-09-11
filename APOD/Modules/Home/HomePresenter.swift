//
//  HomePresenter.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import Foundation

///View protocols
protocol HomeViewProtocol: NSObjectProtocol {
    func fetchPictureDidEnd(picture: Picture)
    func fetchPictureWillStart()
    func showVideo(_ picture: Picture)
    func showImage(_ picture: Picture)
}

///Call backs to view contreoller
protocol HomePresenterDelegate: NSObjectProtocol {
    func isFavourite()
    func isNotFavourite()
}

enum MediaType: String {
    case video
    case image
    
    var mediaType: String { rawValue.uppercased() }
}


class HomePresenter {
    
    private let service: HomeService
    weak private var homeViewProtocol: HomeViewProtocol?
    weak var delegate: HomePresenterDelegate?
    var picture: Picture? = nil
    var imageData: Data? = nil
    
    init(service: HomeService = HomeService()) {
        self.service = service
    }
    
    // MARK: - Private Methods
    /**
     This function prepares the request url for fetching the POD
        - Data parameter: Date to retrieve the POD. If date is niil, then date is not appended to the URL
     */
    func requestUrl(for date:Date?) -> URL? {
        var urlComponents = URLComponents(string: NetworkConstants.baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: ServiceConstants.apiKey, value: NetworkConstants.apiKeyValue),
        ]
        
        if let date = date {
            urlComponents?.queryItems?.append(URLQueryItem(name: ServiceConstants.dateKey, value: date.dateString()))
        }
        return urlComponents?.url
    }
    
    
    // MARK: - Public Methods
    /**
        This function attches the presenter with the view.
        -  HomeView is confirmed to HomeViewProtocol
     */
    func attachView(view: HomeViewProtocol) {
        homeViewProtocol = view
    }
    
    /**
        This function retrieves the POD
        - Data parameter: Date to retrieve the POD. If date is niil, then date is not appended to the request
     */
    func fetchPicture(for date: Date? = nil) {
        imageData = nil
        homeViewProtocol?.fetchPictureWillStart()
        service.fetchPicture(for: requestUrl(for: date)) { [weak self] picture in
            self?.picture = picture
            self?.homeViewProtocol?.fetchPictureDidEnd(picture: picture)
        } onFailure: { errorMessage in
            
        }
    }
    
    ///To determine if the POD loaded is added to Favourite list
    func isFavourite() -> Bool{
        guard let picture = picture else {
            return false
        }
        return Storage().isFavourite(picture)
    }
    
    ///To refersh the navigation right bar button(Favourite Image)
    func refreshFavouriteIcon() {
        switch isFavourite() {
        case true:
            delegate?.isFavourite()
        default:
            delegate?.isNotFavourite()
        }
    }
    
    ///This is called from Controller when the favourite button is tapped
    func favouriteDidTap() {
        switch isFavourite() {
        case true:
            delegate?.isNotFavourite()
            //Delete from the saved list
            Storage().deleteFromFavourites(picture?.url)
        default:
            delegate?.isFavourite()
            
            if let picture = picture {
                //Save image to document directory
                FileHelper().save(fileName: picture.title ?? "",data: imageData)
                //Add to favourite list
                Storage().addToFavourites(picture)
            }
        }
    }
    
    ///Valiodates the media type and return callback to homview accordingly
    func validateMediaType() {
        guard let picture = picture else {
            return
        }
        switch picture.mediaType {
        case MediaType.video.rawValue:
            homeViewProtocol?.showVideo(picture)
        default:
            homeViewProtocol?.showImage(picture)
        }
    }
}
