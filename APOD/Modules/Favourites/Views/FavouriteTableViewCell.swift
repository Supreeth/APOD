//
//  FavouriteTableViewCell.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var podImageView: UIImageView!
    
    var item: POD? {
        didSet {
            guard let item = item else { return }
            setItem(item)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setItem(_ item: POD) {
        titleLable.text = item.title
        if let url = item.hdurl {
            podImageView.setImage(url: url)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
