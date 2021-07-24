//
//  CartItemViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 23.07.2021.
//

import UIKit

protocol CartItemViewCellDelegate: AnyObject {
    func deleteProduct(productId: Int)
}

class CartItemViewCell: UITableViewCell {
    
    weak var delegate: CartItemViewCellDelegate?
    var productId = Int()
    
    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTotalLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView! {
        didSet {
            productImage.layer.cornerRadius = 10
            productImage.layer.masksToBounds = true
            productImage.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteProduct(productId: productId)
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
