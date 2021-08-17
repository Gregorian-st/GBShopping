//
//  ProductViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 19.07.2021.
//

import UIKit

class ProductViewController: UIViewController {
    
    private let cellProductImageReuseID = "productImageCell"
    private let cellProductDetailsReuseID = "productDetailsCell"
    private let cellProductCartReuseID = "productCartCell"
    private let cellReviewCaptionReuseID = "reviewCaptionCell"
    private let cellReviewBodyReuseID = "reviewBodyCell"
    private let cellReviewAddReuseID = "reviewAddCell"
    private let requestFactory = RequestFactory()
    private var productCount: Int = 1
    
    private let userData = UserData.instance
    var product = ProductCatalog()
    var reviews: [ProductReview] = []

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getProductReviews(productId: product.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Segues
    
    @IBAction func unwindFromReview (_ segue: UIStoryboardSegue) {
        getProductReviews(productId: product.id)
    }
    
    // MARK: - Review Methods
    
    private func getProductReviews(productId: Int) {
        let review = requestFactory.makeReviewRequestFatory()
        review.getProductReviews(productId: productId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let productReviews):
                    logging(productReviews)
                    if productReviews.result == 1 {
                        self.reviews = productReviews.reviews
                        if self.reviews.count > 0 {
                            self.tableView.reloadSections([1], with: .fade)
                        }
                    } else {
                        self.reviews = []
                    }
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
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
    
    // MARK: - Basket Methods
    
    private func addToBasket(userId: Int, productId: Int, quantity: Int) {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.addToBasket(userId: userId, productId: productId, quantity: quantity) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let addToBasketResult):
                    logging(addToBasketResult)
                    logAnalytics(messageType: .productAddToCart, messageText: "Product id=\(productId) added to cart")
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }

    // MARK: - App Logic
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backButtonTitle = ""
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "ProductImageViewCell", bundle: nil), forCellReuseIdentifier: cellProductImageReuseID)
        tableView.register(UINib(nibName: "ProductDetailsViewCell", bundle: nil), forCellReuseIdentifier: cellProductDetailsReuseID)
        tableView.register(UINib(nibName: "ProductCartViewCell", bundle: nil), forCellReuseIdentifier: cellProductCartReuseID)
        tableView.register(UINib(nibName: "ReviewCaptionViewCell", bundle: nil), forCellReuseIdentifier: cellReviewCaptionReuseID)
        tableView.register(UINib(nibName: "ReviewBodyViewCell", bundle: nil), forCellReuseIdentifier: cellReviewBodyReuseID)
        tableView.register(UINib(nibName: "ReviewAddViewCell", bundle: nil), forCellReuseIdentifier: cellReviewAddReuseID)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorStyle = .none
    }
    
    private func goToReview() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewViewController = storyboard.instantiateViewController(identifier: "ReviewViewController")
        reviewViewController.modalPresentationStyle = .popover
        (reviewViewController as! ReviewViewController).productId = product.id
        present(reviewViewController, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            // Review Section
            // 0 - Caption
            // 1 - Review
            // Last - Add review button
            return reviews.count + 2
        default:
            // Product Section:
            // 0 - Product Image
            // 1 - Product Details
            // 2 - Add to Cart
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = getProductCell(indexPath: indexPath)
        } else {
            cell = getReviewCell(indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat
        if indexPath.section == 0 {
            switch indexPath.row {
            case 1:
                // Product Details Cell Height
                cellHeight = 150
            case 2:
                // Product Cart Cell Height
                cellHeight = 44
            default:
                // Product Image Cell Height
                cellHeight = tableView.bounds.width / 2
            }
        } else {
            if indexPath.row == 0 {
                // Review Caption Cell Height
                cellHeight = 32
            } else if indexPath.row == reviews.count + 1 {
                // Review Add Cell Height
                cellHeight = 44
            } else {
                // Review Body Cell Height
                cellHeight = 60
            }
        }
        
        return cellHeight
    }
    
    private func getProductCell(indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            // Product Details Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellProductDetailsReuseID, for: indexPath) as! ProductDetailsViewCell
            cell.productNameLabel.text = "\(product.name)"
            cell.productPriceLabel.text = "Price: \(String(format: "%0.2f", product.price)) ₽"
            cell.productDescriptionText.text = "Specifications:\n\(product.description)"
            cell.selectionStyle = .none
            return cell
        case 2:
            // Product Cart Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellProductCartReuseID, for: indexPath) as! ProductCartViewCell
            cell.productCount = productCount
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        default:
            // Product Image Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellProductImageReuseID, for: indexPath) as! ProductImageViewCell
            if let imageURL = URL.init(string: product.image) {
                cell.productImage.load(url: imageURL)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    private func getReviewCell(indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Review Caption Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReviewCaptionReuseID, for: indexPath) as! ReviewCaptionViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == reviews.count + 1 {
            // Review Add Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReviewAddReuseID, for: indexPath) as! ReviewAddViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            // Review Body Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReviewBodyReuseID, for: indexPath) as! ReviewBodyViewCell
            cell.reviewTextView.text = "\(reviews[indexPath.row - 1].commentText)"
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

// MARK: - ProductCartViewCellDelegate

extension ProductViewController: ProductCartViewCellDelegate {
    
    func addProductToCart(quantity: Int) {
        addToBasket(userId: userData.user.id, productId: product.id, quantity: quantity)
        performSegue(withIdentifier: "unwindFromProductInfo", sender: self)
    }
    
}

// MARK: - ReviewAddViewCellDelegate

extension ProductViewController: ReviewAddViewCellDelegate {
    
    func addReview() {
        goToReview()
    }

}
