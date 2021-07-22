//
//  ProductImageViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 20.07.2021.
//

import UIKit

class ProductImageViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var productImage: UIImageView! {
        didSet {
            productImage.layer.cornerRadius = 10
            productImage.layer.masksToBounds = true
            productImage.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
