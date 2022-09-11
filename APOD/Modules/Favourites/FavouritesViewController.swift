//
//  FavouritesViewController.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let adapter = FavouritesAdapter()
    private var presenter: FavouritesPresenter?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString(LocalizeConstants.favouriteScreenTitle, comment: "")
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adapter.list = presenter?.fetchFavourites()
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    // MARK: Setup Methods
    ///Views and Presenters are attached and intial setup is done in this function
    private func setup() {
        presenter = FavouritesPresenter()
        let view = (self.view as? FavouritesView) ?? FavouritesView()
        presenter?.attachView(view: view)
        adapter.delegate = self
        setupTableView()
    }
    
    /**
        Setting up the table view in this function
        -   Tableview delegates and data soure are handled in FavouritesAdapter
     */
    private func setupTableView(){
        tableView.delegate = adapter
        tableView.dataSource = adapter
        let nib = UINib(nibName: NibConstants.favouriteTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NibConstants.favouriteTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    // MARK: - Navigation
    /**
        Preparing before the app is navigated to Favourites detail view
        -   API fetch wont happen for favourites, POD model is passed to next screen
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueConstants.showFavouritesDetailViewController {
            if let viewController = segue.destination as? FavouritesDetailViewController {
                viewController.presenter.pod = presenter?.itemSelected
            }
        }
    }
}

// MARK: - FavouritesAdapterDelegate Methods
extension FavouritesViewController: FavouritesAdapterDelegate {
    func didTap(_ item: POD) {
        presenter?.itemSelected = item
        performSegue(withIdentifier: SegueConstants.showFavouritesDetailViewController, sender: self)
    }
}
