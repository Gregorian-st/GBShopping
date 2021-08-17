//
//  ProductDetailsViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 21.07.2021.
//

import UIKit

class ProductDetailsViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionText: UITextView!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
