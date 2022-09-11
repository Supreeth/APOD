//
//  FavouritesDetailView.swift
//  APOD
//
//  Created by Supreeth Doddabela on 10/09/2022.
//

import UIKit

class FavouritesDetailView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationlabel: UILabel!
}

// MARK: - Extension FavouritesDetailProtocol

///These callbacks will be called from Presenter
extension FavouritesDetailView: FavouritesDetailProtocol {
    func loadView(with pod: POD) {
        dateLabel.text = pod.date
        titleLabel.text = pod.title
        explanationlabel.text = pod.explanation
        
        if let image = FileHelper().getImage(with: pod.title ?? "") {
            imageView.image = image
        } else if let url = pod.hdurl {
            imageView.setImage(url: url, onSuccess:  { image in
                if let imageData =  image.jpegData(compressionQuality: 1.0) {
                    DispatchQueue.main.async {
                        FileHelper().save(fileName: pod.title ?? "",data: imageData)
                    }
                }
            })
        }
    }
}
