//
//  ImageDownloader.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

///This Class is used to download and cache the images for a session
class ImageDownloader: NSObject {
    
    /**
        This function is used to download the images from the server
         -  If image is avaiable in NSCache, this function will retrieve from cache and return
         -  If image not avaialbe in NSCache, image will be downloaded and returned back
     */
    func downloadAndCacheImage(url:String,
                               onSuccess:@escaping (_ image:UIImage?, _ url: String) -> Void,
                               onFailure:@escaping (_ error:Error?) -> Void) -> Void {
        
        guard let requestUrl = URL(string: url) else {
            return
        }
        
        if let image = ImageDownloadManager.sharedInstance.getImage(forUrl: url){
            onSuccess(image, url)
        } else {
            URLSession.shared.dataTask(with: requestUrl, completionHandler: { (data, response, error) in
                
                if error != nil {
                    onFailure(error)
                }else{
                    guard let data = data else {
                        return
                    }
                    
                    if let image = UIImage(data: data){
                        ImageDownloadManager.sharedInstance.setImage(image: image, forKey: url)
                        onSuccess(image, url)
                    } else {
                        onFailure(NSError(domain: "", code: 100, userInfo: ["reason":"Unable to download image"]))
                    }
                    
                }
            }).resume()
        }
    }
}
