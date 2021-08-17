//
//  ReviewBodyViewCell.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 21.07.2021.
//

import UIKit

class ReviewBodyViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var reviewTextView: UITextView! {
        didSet {
            reviewTextView.textColor = .label
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
