//
//  HomeViewController.swift
//  LevelShoes
//
//  Created by Renato Mateus on 27/05/22.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var topBookmarkImageView: UIImageView!
    
    // MARK: - Private Properties
    internal let viewModel = HomeViewModel(with: PopularProductsService())
    var products: Products = []
    var dataProducts: DataProducts?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationToWishList()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}


// MARK: - Setup UI
extension HomeViewController {
    func setupUI() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: ProductsViewCell.identifier,
                                      bundle: nil),
                                forCellWithReuseIdentifier: ProductsViewCell.identifier)
        
        let spacing: CGFloat = 5
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func done() { // remove @objc for Swift 3

    }
}

// MARK: - SetupData
extension HomeViewController {
    func setupData() {
        viewModel.delegate = self
        self.collectionView.showLoading()
        viewModel.fetchData()
    }
}

// MARK: - ViewControllerViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func onSuccessFetchingProducts(products: DataProducts) {
        DispatchQueue.main.async {
            self.dataProducts = products
            if let results = products.items {
                self.products = results
            }
            self.topTitleLabel.text = self.dataProducts?.title
            self.showCollectionView()
        }
    }
    
    func onFailureFetchingProducts(error: Error) {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = self.getEmptyView()
        }
    }
    
    func setupNavigationToWishList() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToWishList))
        self.topBookmarkImageView.isUserInteractionEnabled = true
        self.topBookmarkImageView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var product = self.products[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsViewCell.identifier,
                                                            for: indexPath) as? ProductsViewCell  else { return  UICollectionViewCell() }
        product.isFavorite = viewModel.isFavoritedProduct(product: product)
        cell.setupData(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.selectProduct(product)
    }
}

// MARK: - UICollectionViewLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:( self.view.frame.size.width / 2 - 3 ), height: 300)
    }
}

// MARK: - Scroll Delegate
extension HomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.collectionView.showLoading()
            viewModel.fetchData()
        }
    }
}

// MARK: - Helpers
private extension HomeViewController {
    func getEmptyView() -> UIView {
        let labelDescription: UILabel = UILabel()
        labelDescription.font = .systemFont(ofSize: 20, weight: .regular)
        labelDescription.textColor = UIColor.darkGray
        labelDescription.numberOfLines = 0
        labelDescription.textAlignment = .center
        labelDescription.text = "Looks like you have a empty data."
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.sizeToFit()
        
        return labelDescription
    }
    
    func showCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = nil
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Selection Movie
/// This could be inside a coordinate because sometime we'll need to go to this new screen from more than one place.
extension HomeViewController {
    func selectProduct(_ product: Product) {
        DispatchQueue.main.async {
            let productDetailController = ProductDetailViewController(with: product)
            self.navigationController?.pushViewController(productDetailController, animated: true)
        }
    }
    
    /// I could have a coordination class to coordinate the navigation for this screen, since we have it triggered from more than 1 place.
    @objc func navigateToWishList(_ sender: UITapGestureRecognizer) {
        DispatchQueue.main.async {
            let controller = WishListViewController()
            controller.delegate = self
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: WishListViewControllerDelegate {
    func didRemoveFavoriteItem() {
        self.collectionView.reloadData()
    }
}
