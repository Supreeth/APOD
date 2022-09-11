//
//  ImageDownloadManager.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

///This Class will take of handling the images with NSCache
class ImageDownloadManager: NSObject {
    
    static let sharedInstance = ImageDownloadManager()
    var imageCache:NSCache<NSString, UIImage>
    
    
    override init() {
        self.imageCache = NSCache()
    }
    
    ///Retrieves the image from the cache
    func getImage(forUrl url:String) -> UIImage? {
        return self.imageCache.object(forKey: url as NSString)
    }
    
    ///Store the image to cache
    func setImage(image:UIImage,forKey url:String) -> Void {
        self.imageCache.setObject(image, forKey: url as NSString)
    }
}
