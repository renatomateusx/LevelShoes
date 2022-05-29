//
//  WishListViewController.swift
//  LevelShoes
//
//  Created by Renato Mateus on 28/05/22.
//

import UIKit

protocol WishListViewControllerDelegate: AnyObject {
    func didRemoveFavoriteItem()
}

class WishListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    internal let viewModel = WishListViewModel()
    
    // MARK: - Delegate
    var delegate: WishListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        closeButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        tableView.register(UINib(nibName: ProductTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupData() {
        if viewModel.favoriteList?.count == 0 {
            self.tableView.backgroundView = self.getEmptyView()
        } else {
            self.showTableView()
        }
        titleView.text = "WISHLIST (\(viewModel.favoriteList?.count ?? 0))"
    }
    
    @objc func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Delegate

extension WishListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Table view data source
extension WishListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.viewModel.favoriteList?[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier,
                                                       for: indexPath) as? ProductTableViewCell  else { return  UITableViewCell() }
        cell.setupData(with: product)
        cell.delegate = self
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = viewModel.favoriteList?.count ?? 0
        return result
    }
}

// MARK: - Helpers
private extension WishListViewController {
    func getEmptyView() -> UIView {
        let labelDescription: UILabel = UILabel()
        labelDescription.font = .systemFont(ofSize: 20, weight: .regular)
        labelDescription.textColor = UIColor.darkGray
        labelDescription.numberOfLines = 0
        labelDescription.textAlignment = .center
        labelDescription.text = "You don't have any favorite products yet."
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.sizeToFit()
        labelDescription.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        return labelDescription
    }
    
    func showTableView() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        }
    }
}

extension WishListViewController: ProductTableViewCellDelegate {
    func productRemovedFromWhishList(_ product: Product) {
        DispatchQueue.main.async {
            self.viewModel.updateList()
            self.tableView.reloadData()
            self.setupData()
            self.showAlert(title: "REMOVED!", message: "Product removed from whishlist")
            self.delegate?.didRemoveFavoriteItem()
        }
    }
}

private extension WishListViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
}

