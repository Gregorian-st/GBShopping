//
//  CartPayViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 23.07.2021.
//

import UIKit

protocol CartPayViewCellDelegate: AnyObject {
    func cartPay()
}

class CartPayViewCell: UITableViewCell {
    
    weak var delegate: CartPayViewCellDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton! {
        didSet {
            payButton.layer.cornerRadius = payButton.frame.size.height / 2
        }
    }
    
    // MARK: - Actions
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        delegate?.cartPay()
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
