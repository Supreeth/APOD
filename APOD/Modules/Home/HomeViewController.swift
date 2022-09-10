//
//  ViewController.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var presenter: HomePresenter?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        setupNavigationbar()
        presenter?.fetchPicture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.refreshFavouriteIcon()
    }
    
    // MARK: - Private Methods
    // MARK: Setup Methods
    private func setUp() {
        presenter = HomePresenter()
        let view = (self.view as? HomeView) ?? HomeView()
        presenter?.attachView(view: view)
        presenter?.delegate = self
        view.delegate = self
        view.setup()
    }
    
    private func setupNavigationbar() {
        self.title = NSLocalizedString(LocalizeConstants.homeScreenTitle, comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: NavigationConstants.favouriteIcon),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: NavigationConstants.calendarIcon),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonTapped)
        )
    }
    
    // MARK: Action Methods
    @objc private func rightBarButtonTapped(){
        presenter?.refreshFavouriteIcon()
        presenter?.favouriteDidTap()
    }
    
    @objc private func leftBarButtonTapped() {
        let view = (self.view as? HomeView) ?? HomeView()
        view.datePickerView.isHidden = false
    }
}

extension HomeViewController: HomeViewDelegate {
    func fetchPicture(for date: Date) {
        presenter?.fetchPicture(for: date)
    }
    
    func fetchPictureDidEnd(picture: Picture) {
        guard let isFavourite = presenter?.isFavourite() else{
            return
        }
        
        let image = isFavourite ? UIImage(systemName: NavigationConstants.favouriteFillIcon) : UIImage(systemName: NavigationConstants.favouriteIcon)
        navigationItem.rightBarButtonItem?.image = image
    }
}

extension HomeViewController: HomePresenterDelegate {
    func isFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteFillIcon)
    }
    
    func isNotFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteIcon)
    }
}
