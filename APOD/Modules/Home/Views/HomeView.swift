//
//  HomeView.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import UIKit

protocol HomeViewDelegate:NSObjectProtocol {
    func fetchPicture(for date: Date)
    func fetchPictureDidEnd(picture: Picture)
}

class HomeView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationlabel: UILabel!
    @IBOutlet weak var datePickerView: DatePickerView!
    weak var delegate: HomeViewDelegate?
    private var myActivityIndicator: UIActivityIndicatorView?
    
    func setup() {
        datePickerView.delegate = self
        if !Reachability.sharedInstance.isNetworkAvailable() {
            guard let picture = Storage().fetchRecentPicture() else {
                return
            }
            titleLabel.text = picture.title
            dateLabel.text = picture.date
            explanationlabel.text = picture.explanation
            if let imageData = picture.imageData {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
}

extension HomeView: HomeViewProtocol{
    
    func fetchPictureWillStart() {
        guard var myActivityIndicator = myActivityIndicator else {
            return
        }
        myActivityIndicator = UIActivityIndicatorView(style: .large)
        myActivityIndicator.center = center
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.startAnimating()
        addSubview(myActivityIndicator)
    }
    
    func fetchPictureDidEnd(picture: Picture) {
        if let url = picture.hdurl {
            imageView.setImage(url: url, onSuccess:  { image in
                image.save(fileName: FileKeyConstants.pictureKey)
                if let imageData =  image.jpegData(compressionQuality: 1.0) {
                    DispatchQueue.main.async {
                        Storage().storeRecentPicture(picture, imagData: imageData)
                    }
                }
            })
        }
        dateLabel.text = picture.date
        titleLabel.text = picture.title
        explanationlabel.text = picture.explanation
        myActivityIndicator?.stopAnimating()
        
        delegate?.fetchPictureDidEnd(picture: picture)
    }
}

extension HomeView: DatePickerDelegate{
    func doneButtonTapped(date: Date) {
        delegate?.fetchPicture(for: date)
    }
}
