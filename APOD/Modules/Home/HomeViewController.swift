//
//  ViewController.swift
//  APOD
//
//  Created by Supreeth Doddabela on 08/09/2022.
//

import UIKit
///Controller Class to handle and display the Picture of the day
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
    ///Views and Presenters are attached and intial setup is done in this function
    private func setUp() {
        presenter = HomePresenter()
        let view = (self.view as? HomeView) ?? HomeView()
        presenter?.attachView(view: view)
        presenter?.delegate = self
        view.delegate = self
        view.setup()
        self.title = NSLocalizedString(LocalizeConstants.homeScreenTitle, comment: "")
    }
    
    /// Navigation items are set here in this function
    private func setupNavigationbar() {
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

// MARK: - Extension HomeViewDelegate
/// Call backs from Home View
extension HomeViewController: HomeViewDelegate {
    ///This function is called on Datepicker done button tap
    func fetchPicture(for date: Date) {
        presenter?.fetchPicture(for: date)
    }
    
    ///This function is called when API fetch of POD is completed in presenter
    func fetchPictureDidEnd(picture: Picture) {
        guard let isFavourite = presenter?.isFavourite() else{
            return
        }
        
        let image = isFavourite ? UIImage(systemName: NavigationConstants.favouriteFillIcon) : UIImage(systemName: NavigationConstants.favouriteIcon)
        navigationItem.rightBarButtonItem?.image = image
    }
}

// MARK: - Extension HomePresenterDelegate
/// Call backs from HomeViewPresenter
extension HomeViewController: HomePresenterDelegate {
    ///This function is called if the POD is favourite
    func isFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteFillIcon)
    }
    
    ///This function is called if the POD is not  favourite
    func isNotFavourite() {
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: NavigationConstants.favouriteIcon)
    }
    
    ///This function is called once POD image is lazy loaded
    func imageDidLoad(with imageData: Data) {
        presenter?.imageData = imageData
    }
}
