//
//  WishListViewController.swift
//  LevelShoes
//
//  Created by Renato Mateus on 28/05/22.
//

import UIKit

class WishListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    internal let viewModel = WishListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        closeButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        titleView.text = "WISHLIST (\(viewModel.favoriteList?.count ?? 0))"
        
        tableView.register(UINib(nibName: ProductTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
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
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteList?.count ?? 0
    }
}
