//
//  ReviewAddViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 21.07.2021.
//

import UIKit

class ReviewAddViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var addReviewButton: UIButton! {
        didSet {
            addReviewButton.layer.cornerRadius = addReviewButton.frame.size.height / 2
            addReviewButton.layer.borderWidth = 0.5
            addReviewButton.layer.borderColor = UIColor.systemGreen.cgColor
            addReviewButton.layer.masksToBounds = true
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
