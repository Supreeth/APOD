//
//  FavouritesAdapter.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

protocol FavouritesAdapterDelegate: AnyObject {
    func didTap(_ item: POD)
}

class FavouritesAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    let identifier = "FavouriteTableViewCell"
    
    var list: [POD]?
    
    weak var delegate: FavouritesAdapterDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavouriteTableViewCell {
            cell.item = list?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = list?[indexPath.row] else { return }
        delegate?.didTap(item)
    }
}
