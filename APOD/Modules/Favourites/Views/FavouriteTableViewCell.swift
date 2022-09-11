//
//  FavouriteTableViewCell.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit
import AVKit

class FavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var podImageView: UIImageView!
    
    var item: POD? {
        didSet {
            guard let item = item else { return }
            setItem(item)
        }
    }
    
    private func setItem(_ item: POD) {
        titleLable.text = item.title
        
        if let image = FileHelper().getImage(with: item.title ?? "") {
            podImageView.image = image
        } else if let url = item.hdurl, item.mediaType == "image" {
            podImageView.setImage(url: url,placeholderImage:  UIImage(named: AssetsConstant.placeHolderImage), onSuccess:  { image in
                if let imageData =  image.jpegData(compressionQuality: 1.0) {
                    DispatchQueue.main.async {
                        FileHelper().save(fileName: item.title ?? "",data: imageData)
                    }
                }
            })
        } else if item.mediaType == "video" {
            podImageView.image = UIImage(named: AssetsConstant.videoPlaceHolderImage)
        }
    }
}


