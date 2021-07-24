//
//  CatalogViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 12.07.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private let cellHeight: CGFloat = 84
    private let cellCatalogReuseID = "catalogCell"
    
    private let requestFactory = RequestFactory()
    private var goods: [ProductCatalog] = []
    private var productSelected = ProductCatalog()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        productCatalogData(categoryId: 1, pageNumber: 1)
    }
    
    // MARK: - Segues
    
    @IBAction func unwindFromProductInfo (_ segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productViewController = segue.destination as? ProductViewController
        else { return }
        
        productViewController.product = productSelected
        productViewController.hidesBottomBarWhenPushed = true
    }
    
    // MARK: - Product Methods
    
    private func productCatalogData(categoryId: Int, pageNumber: Int) {
        let product = requestFactory.makeProductRequestFatory()
        product.catalogData(categoryId: categoryId, pageNumber: pageNumber) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let products):
                    logging(products)
                    if products.products.count == 0 {
                        showAlert(alertMessage: "Empty catalog!", viewController: self)
                    }
                    self.goods = products.products
                    self.tableView.reloadData()
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }
    
    private func productGetGoodById(productId: Int) {
        let product = requestFactory.makeProductRequestFatory()
        product.getGoodById(productId: productId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let product):
                    logging(product)
                    if product.result == 1 {
                        self.productSelected = product.product
                        self.performSegue(withIdentifier: "showProductInfo", sender: nil)
                    } else {
                        showAlert(alertMessage: "Wrong product ID!", viewController: self)
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backButtonTitle = ""
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CatalogViewCell", bundle: nil), forCellReuseIdentifier: cellCatalogReuseID)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CatalogViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellCatalogReuseID, for: indexPath) as! CatalogViewCell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productGetGoodById(productId: goods[indexPath.row].id)
    }
    
}
