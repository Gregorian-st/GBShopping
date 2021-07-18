//
//  CatalogViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 18.07.2021.
//

import UIKit

class CatalogViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView! {
        didSet {
            productImage.layer.cornerRadius = 10
            productImage.layer.masksToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
