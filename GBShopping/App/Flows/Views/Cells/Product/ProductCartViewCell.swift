//
//  ProductCartViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 21.07.2021.
//

import UIKit

protocol ProductCartViewCellDelegate: AnyObject {
    func addProductToCart(quantity: Int)
}

class ProductCartViewCell: UITableViewCell {
    
    weak var delegate: ProductCartViewCellDelegate?
    var productCount: Int = 1 {
        didSet {
            if productCount < 1 {
                productCount = 1
            }
            if productCount > 10 {
                productCount = 10
            }
            countTextField.text = "\(productCount)"
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton! {
        didSet {
            addToCartButton.layer.cornerRadius = addToCartButton.frame.size.height / 2
        }
    }
    @IBOutlet weak var countTextField: UITextField! {
        didSet {
            countTextField.layer.cornerRadius = countTextField.frame.size.height / 2
            countTextField.layer.borderWidth = 0.5
            countTextField.layer.borderColor = UIColor.systemGray2.cgColor
            countTextField.layer.masksToBounds = true
        }
    }
    
    // MARK: - Actions
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        productCount += 1
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        productCount -= 1
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        delegate?.addProductToCart(quantity: productCount)
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
