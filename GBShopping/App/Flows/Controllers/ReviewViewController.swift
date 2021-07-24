//
//  ReviewViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 24.07.2021.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    private let userData = UserData.instance
    
    var productId = Int()
    
    // MARK: - Outlets
    
    @IBOutlet weak var reviewTextView: UITextView! {
        didSet {
            reviewTextView.layer.cornerRadius = 10
            reviewTextView.layer.borderWidth = 0.5
            reviewTextView.layer.borderColor = UIColor.systemGray2.cgColor
        }
    }
    @IBOutlet weak var addReviewButton: UIButton! {
        didSet {
            addReviewButton.layer.cornerRadius = addReviewButton.frame.size.height / 2
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Actions
    
    @IBAction func addReviewButtonTapped(_ sender: UIButton) {
        let reviewText = reviewTextView.text?.trimmingCharacters(in: [" "]) ?? ""
        if !reviewText.isEmpty {
            addProductReview(userId: userData.user.id, productId: productId, commentText: reviewText)
        } else {
            showAlert(alertMessage: "Please write something!", viewController: self)
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    // MARK: - Review Methods
    
    private func addProductReview(userId: Int, productId: Int, commentText: String) {
        let review = requestFactory.makeReviewRequestFatory()
        review.addProductReview(userId: userId,
                                productId: productId,
                                commentText: commentText) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let productReview):
                    logging(productReview)
                    if productReview.result == 1 {
                        self.performSegue(withIdentifier: "unwindFromReview", sender: self)
                    }
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }
    
    // MARK: - App Logic
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
    }
    
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
}
