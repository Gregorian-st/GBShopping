//
//  CartViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 14.07.2021.
//

import UIKit

class CartViewController: UIViewController {
    
    private let cellCartItemReuseID = "cartItemCell"
    private let cellCartPayReuseID = "cartPayCell"
    
    private let requestFactory = RequestFactory()
    private let userData = UserData.instance
    
    var cart = GetBasketResult()
    
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
        getBasket(userId: userData.user.id)
    }
    
    // MARK: - Basket Methods
    
    private func deleteFromBasket(userId: Int, productId: Int) {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.deleteFromBasket(userId: userId, productId: productId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let deleteFromBasketResult):
                    logging(deleteFromBasketResult)
                    if deleteFromBasketResult.result == 1 {
                        self.getBasket(userId: userId)
                    }
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }
    
    private func getBasket(userId: Int) {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.getBasket(userId: 123) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let basket):
                    logging(basket)
                    self.cart = basket
                    self.tableView.reloadData()
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }
    
    private func payBasket(userId: Int) {
        let basket = requestFactory.makeBasketRequestFatory()
        basket.payBasket(userId: userId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let payBasketResult):
                    logging(payBasketResult)
                    if payBasketResult.result == 1 {
                        showAlert(alertMessage: "Thank you for payment!", viewController: self)
                        self.getBasket(userId: userId)
                    }
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
        tableView.register(UINib(nibName: "CartItemViewCell", bundle: nil), forCellReuseIdentifier: cellCartItemReuseID)
        tableView.register(UINib(nibName: "CartPayViewCell", bundle: nil), forCellReuseIdentifier: cellCartPayReuseID)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.contents.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cart.contents.count {
            // Cart Pay Cell Height
            return 62
        } else {
            // Cart Item Cell Height
            return 84
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == cart.contents.count {
            // Cart Pay Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellCartPayReuseID, for: indexPath) as! CartPayViewCell
            cell.delegate = self
            if cart.contents.count == 0 {
                cell.totalLabel.textAlignment = .center
                cell.totalLabel.textColor = .systemGray2
                cell.totalLabel.text = "Cart is empty"
                cell.payButton.isHidden = true
            } else {
                cell.totalLabel.textAlignment = .left
                cell.totalLabel.textColor = .label
                cell.totalLabel.text = "Total: \(String(format: "%0.2f", cart.amount)) ₽"
                cell.payButton.isHidden = false
            }
            cell.selectionStyle = .none
            return cell
        } else {
            // Cart Item Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: cellCartItemReuseID, for: indexPath) as! CartItemViewCell
            cell.productId = cart.contents[indexPath.row].product.id
            if let imageURL = URL.init(string: cart.contents[indexPath.row].product.image) {
                cell.productImage.load(url: imageURL)
            }
            cell.productNameLabel.text = "\(cart.contents[indexPath.row].product.name)"
            cell.productPriceLabel.text = "Price: \(String(format: "%0.2f", cart.contents[indexPath.row].product.price)) ₽ x \(cart.contents[indexPath.row].quantity)"
            cell.productTotalLabel.text = "Total: \(String(format: "%0.2f", cart.contents[indexPath.row].product.price * Float(cart.contents[indexPath.row].quantity))) ₽"
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }

}

// MARK: - CartItemViewCellDelegate

extension CartViewController: CartItemViewCellDelegate {
    
    func deleteProduct(productId: Int) {
        deleteFromBasket(userId: userData.user.id, productId: productId)
    }

}

// MARK: - CartPayViewCellDelegate

extension CartViewController: CartPayViewCellDelegate {
    
    func cartPay() {
        payBasket(userId: userData.user.id)
    }
    
}
