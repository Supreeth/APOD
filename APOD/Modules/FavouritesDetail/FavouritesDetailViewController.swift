//
//  FavouritesDetailViewController.swift
//  APOD
//
//  Created by Supreeth Doddabela on 10/09/2022.
//

import UIKit

class FavouritesDetailViewController: UIViewController {
    
    var presenter: FavouritesDetailPresenter = FavouritesDetailPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupNavigationbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.willPop(isMovingFromParent)
    }
    
    private func setUp() {
        let view = (self.view as? FavouritesDetailView) ?? FavouritesDetailView()
        presenter.attachView(view: view)
        presenter.delegate = self
    }
    
    private func setupNavigationbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: NavigationConstants.favouriteFillIcon),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
    }
    
    // MARK: Action Methods
    @objc private func rightBarButtonTapped(){
        presenter.favouriteDidTap()
    }
}

extension FavouritesDetailViewController: FavouritesDetailPresenterDelegate {
    func isFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteIcon)
    }
    
    func isNotFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteFillIcon)
    }
}
