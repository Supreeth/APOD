//
//  ImageViewExtension.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

extension UIImageView {
    
    func setImage(url: String,
                  placeholderImage: UIImage? = nil,
                  onSuccess successCallback: ((_ image: UIImage) -> Void)? = nil,
                  onFailure failureCallback: ((_ errorMessage: String) -> Void)? = nil) {

        image = nil
        
        if let image = placeholderImage {
            self.image = image
        } else{
            backgroundColor = .gray
        }
        
        let myActivityIndicator = UIActivityIndicatorView(style: .medium)
        myActivityIndicator.center = center
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.startAnimating()
        addSubview(myActivityIndicator)
        
        ImageDownloader().downloadAndCacheImage(url: url, onSuccess: { (image, url) in
            DispatchQueue.main.async {
                myActivityIndicator.stopAnimating()
                myActivityIndicator.removeFromSuperview()
                self.image = image
                self.backgroundColor = .clear
            }
            successCallback?(image ?? UIImage())
        }) { error in
            failureCallback?(error?.localizedDescription ?? "")
        }
    }
}
