//
//  FavouritesDetailViewController.swift
//  APOD
//
//  Created by Supreeth Doddabela on 10/09/2022.
//

import UIKit

class FavouritesDetailViewController: UIViewController {
    
    var presenter: FavouritesDetailPresenter = FavouritesDetailPresenter()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupNavigationbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.willPop(isMovingFromParent)
    }
    
    // MARK: - Private Methods
    ///Views and Presenters are attached and intial setup is done in this function
    private func setUp() {
        let view = (self.view as? FavouritesDetailView) ?? FavouritesDetailView()
        presenter.attachView(view: view)
        presenter.delegate = self
    }
    
    /// Navigation items are set here in this function
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

// MARK: - FavouritesDetailPresenterDelegate Methods

///Call backs from FavouritesDetailPresenter
extension FavouritesDetailViewController: FavouritesDetailPresenterDelegate {
    ///This function is called if the POD is favourite
    func isFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteIcon)
    }
    
    ///This function is called if the POD is not  favourite
    func isNotFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteFillIcon)
    }
}
