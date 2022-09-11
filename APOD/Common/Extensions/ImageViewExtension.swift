//
//  ImageViewExtension.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

extension UIImageView {
    
    /**
        This function will be called while setting the UIImage to UIImageView
        -  Fetches the images from the server/cache and set to 'image' property of the UIImage
        -  Sets placeholder while retrieving the image
     */
    func setImage(url: String,
                  placeholderImage: UIImage? = nil,
                  onSuccess successCallback: ((_ image: UIImage) -> Void)? = nil,
                  onFailure failureCallback: ((_ errorMessage: String) -> Void)? = nil) {

        image = nil
        
        //Setting the placeholder till the image is downloaded
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
        
        //Download image from the server or fetch form the cahce if available
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
