//
//  DishwashersViewController.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 19/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class DishwashersViewController: UIViewController {

    private var viewModel: DishwashersViewModel?
    private let numberOfCellsPerRowPadPotrait: CGFloat = 3
    private let numberOfCellsPerRowPadLandscape: CGFloat = 4

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let name = String(describing: DishwasherCell.self)
            collectionView.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
        }
    }

    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("NavigationBarTitle", comment: "Navigation bar title")
        collectionView.delegate = self
        collectionView.dataSource = self
        addNavigationItems()
        refreshData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        reloadView()
    }

    private func addNavigationItems() {
        let activityBarButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem  = activityBarButton
        activityIndicator.startAnimating()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reload",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(reloadView))
    }

    private func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func setup(_ cell: DishwasherCell, forRowAt indexPath: IndexPath) -> DishwasherCell {
        cell.titleLabel.text = viewModel?.title(for: indexPath.row)
        cell.priceLabel.text = viewModel?.price(for: indexPath.row)
        return cell
    }

    private func cellWidth() -> CGFloat {
        if UIDevice.current.orientation.isLandscape {
            return cellWidth(numberOfCells: numberOfCellsPerRowPadLandscape)
        } else {
            return cellWidth(numberOfCells: numberOfCellsPerRowPadPotrait)
        }
    }

    private func cellWidth(numberOfCells: CGFloat) -> CGFloat {
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return view.frame.width / numberOfCells
        }
        let lineSpacing = flowLayout.minimumLineSpacing * (numberOfCells - 1)
        return (view.frame.width - lineSpacing) / numberOfCells
    }
}

extension DishwashersViewController: ContentLoadable {
    func prepareData(_ completion: @escaping ContentLoadableCompletion) {
        viewModel = DishwashersViewModel(dishwashers: Factory.createDishwashers())
        completion(nil)
    }

    @objc func reloadView() {
        collectionView.reloadData()
    }

    func showLoadingView() {
        activityIndicator.startAnimating()
    }

    func hideLoadingView() {
        activityIndicator.stopAnimating()
    }

    func showError(_ error: Error) {
        showError(error)
    }
}

extension DishwashersViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.dishwashers.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DishwasherCell.self),
                                                      for: indexPath)
        guard let dishwasherCell = cell as? DishwasherCell else { return DishwasherCell() }
        return setup(dishwasherCell, forRowAt: indexPath)
    }
}

extension DishwashersViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: cellWidth(), height: cellWidth() * 1.41)
    }
}
