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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Favourites"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adapter.list = presenter?.fetchFavourites()
        tableView.reloadData()
    }
    
    func setup() {
        presenter = FavouritesPresenter()
        let view = (self.view as? FavouritesView) ?? FavouritesView()
        presenter?.attachView(view: view)
        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavouriteTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavouritesDetailViewController" {
            if let viewController = segue.destination as? FavouritesDetailViewController {
                viewController.presenter.pod = presenter?.itemSelected
            }
        }
    }
}

extension FavouritesViewController: FavouritesAdapterDelegate {
    func didTap(_ item: POD) {
        presenter?.itemSelected = item
        performSegue(withIdentifier: "showFavouritesDetailViewController", sender: self)
    }
}
