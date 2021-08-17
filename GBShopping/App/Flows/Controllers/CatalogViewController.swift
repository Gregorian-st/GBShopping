//
//  CatalogViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 12.07.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private let cellHeight: CGFloat = 84
    
    private let requestFactory = RequestFactory()
    private var goods: [ProductCatalog] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        productCatalogData(categoryId: 1, pageNumber: 1)
    }
    
    // MARK: - Product Methods
    
    private func productCatalogData(categoryId: Int, pageNumber: Int) {
        let product = requestFactory.makeProductRequestFatory()
        product.catalogData(categoryId: categoryId, pageNumber: pageNumber) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let products):
                    logging(products)
                    self.goods = products.products
                    self.tableView.reloadData()
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }
    
    private func productGetGoodById() {
        let product = requestFactory.makeProductRequestFatory()
        product.getGoodById(productId: 101) { response in
            switch response.result {
            case .success(let product):
                logging(product)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Review Methods
    
    private func getProductReviews() {
        let review = requestFactory.makeReviewRequestFatory()
        review.getProductReviews(productId: 101) { response in
            switch response.result {
            case .success(let productReviews):
                logging(productReviews)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func addProductReview() {
        let review = requestFactory.makeReviewRequestFatory()
        review.addProductReview(userId: 123,
                                productId: 101,
                                commentText: "Very good laptop!") { response in
            switch response.result {
            case .success(let productReview):
                logging(productReview)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func removeProductReview() {
        let review = requestFactory.makeReviewRequestFatory()
        review.removeProductReview(userId: 123,
                                   productId: 123,
                                   commentId: 1) { response in
            switch response.result {
            case .success(let productReview):
                logging(productReview)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    // MARK: - App Logic
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backButtonTitle = ""
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CatalogViewCell", bundle: nil), forCellReuseIdentifier: "catalogCell")
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorStyle = .none
    }
    
}

extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath) as! CatalogViewCell
        cell.productNameLabel.text = "\(goods[indexPath.row].name)"
        cell.productPriceLabel.text = "Price: \(String(format: "%0.2f", goods[indexPath.row].price)) ₽"
        cell.productDescriptionLabel.text = "\(goods[indexPath.row].description)"
        if let imageURL = URL.init(string: goods[indexPath.row].image) {
            cell.productImage.load(url: imageURL)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
}
