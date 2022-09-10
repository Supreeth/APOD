//
//  HomeService.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import Foundation

class HomeService {
    
    func fetchPicture(for url: URL? = nil,
                      onSuccess successCallback: ((_ picture: Picture) -> Void)?,
                      onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
      
        guard let url = url else {
            return
        }
        
        NetworkManager().request(fromURL: url) { (result: Result<Picture, Error>) in
            switch result {
            case .success(let picture):
                DispatchQueue.main.async {
                    successCallback?(picture)
                }
            case .failure(let error):
                failureCallback?(error.localizedDescription)
            }
        }
    }
}
