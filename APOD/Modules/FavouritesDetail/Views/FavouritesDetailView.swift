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

extension FavouritesDetailView: FavouritesDetailProtocol {
    func loadView(with pod: POD) {
        dateLabel.text = pod.date
        titleLabel.text = pod.title
        explanationlabel.text = pod.explanation
        if let url = pod.hdurl {
            imageView.setImage(url: url) { image in
                image.save(fileName: FileKeyConstants.pictureKey)
            }
        }
    }
}
