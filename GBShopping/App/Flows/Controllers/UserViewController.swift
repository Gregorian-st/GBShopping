//
//  UserViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 12.07.2021.
//

import UIKit

class UserViewController: UIViewController {
    
    private var passwordText = String()
    private var repeatPasswordText = String()
    private var nameText = String()
    private var surnameText = String()
    private var genderText = String()
    private var emailText = String()
    private var creditCardText = String()
    private var bioText = String()
    private let requestFactory = RequestFactory()
    private let userData = UserData.instance
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tag = 1
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var repeatPasswordTextField: UITextField! {
        didSet {
            repeatPasswordTextField.tag = 2
            repeatPasswordTextField.delegate = self
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.tag = 3
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var surnameTextField: UITextField! {
        didSet {
            surnameTextField.tag = 4
            surnameTextField.delegate = self
        }
    }
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.tag = 5
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var creditCardTextField: UITextField! {
        didSet {
            creditCardTextField.tag = 6
            creditCardTextField.delegate = self
        }
    }
    @IBOutlet weak var bioTextField: UITextField! {
        didSet {
            bioTextField.tag = 7
            bioTextField.delegate = self
        }
    }
    @IBOutlet weak var updateButton: UIButton! {
        didSet {
            updateButton.layer.cornerRadius = updateButton.frame.size.height / 2
        }
    }
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.layer.cornerRadius = logoutButton.frame.size.height / 2
        }
    }
    
    // MARK: - Actions
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        authLogout(userId: userData.user.id)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        changeUserData()
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
        presentUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Auth Methods
    
    private func authChangeUserData(userId: Int,
                                    loginName: String,
                                    password: String,
                                    name: String,
                                    surname: String,
                                    email: String,
                                    gender: String,
                                    creditCard: String,
                                    bio: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.changeUserData(userId: userId,
                            loginName: loginName,
                            password: password,
                            name: name,
                            surname: surname,
                            email: email,
                            gender: gender,
                            creditCard: creditCard,
                            bio: bio) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let changeUserData):
                    logging(changeUserData)
                    if changeUserData.result == 1 {
                        showAlert(alertMessage: "User Info has been updated successfully.", viewController: self)
                        self.updateCurrentUser()
                        self.presentUserInfo()
                    } else {
                        showAlert(alertMessage: "Wrong request!", viewController: self)
                    }
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                }
            }
        }
    }
    
    private func authLogout(userId: Int) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.logout(userId: userId) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let logout):
                    logging(logout)
                    if logout.result == 1 {
                        logAnalytics(messageType: .logout, messageText: "User logout")
                        self.performSegue(withIdentifier: "unwindFromUserInfo", sender: self)
                    } else {
                        showAlert(alertMessage: "Wrong request!", viewController: self)
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
    
    private func presentUserInfo() {
        passwordText = ""
        repeatPasswordText = ""
        nameText = userData.user.name
        surnameText = userData.user.surname
        genderText = userData.user.gender
        emailText = userData.user.email
        creditCardText = userData.user.creditCard
        bioText = userData.user.bio
        
        passwordTextField.text = passwordText
        repeatPasswordTextField.text = repeatPasswordText
        nameTextField.text = nameText
        surnameTextField.text = surnameText
        genderSegmentedControl.selectedSegmentIndex = genderText == "M" ? 0 : 1
        emailTextField.text = emailText
        creditCardTextField.text = creditCardText
        bioTextField.text = bioText
    }
    
    private func changeUserData() {
        if validateUserInfo() {
            authChangeUserData(userId: userData.user.id,
                               loginName: UserData.instance.user.login,
                               password: passwordText,
                               name: nameText,
                               surname: surnameText,
                               email: emailText,
                               gender: genderText,
                               creditCard: creditCardText,
                               bio: bioText)
        }
    }
    
    private func validateUserInfo() -> Bool {
        passwordText = passwordTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        repeatPasswordText = repeatPasswordTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        nameText = nameTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        surnameText = surnameTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        genderText = genderSegmentedControl.selectedSegmentIndex == 0 ? "M" : "F"
        emailText = emailTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        creditCardText = creditCardTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        bioText = bioTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        
        if passwordText.isEmpty ||
            repeatPasswordText.isEmpty ||
            nameText.isEmpty ||
            surnameText.isEmpty ||
            emailText.isEmpty ||
            creditCardText.isEmpty {
            showAlert(alertMessage: "All fields except 'Additional Info' must be filled out!", viewController: self)
            return false
        }
        
        if passwordText != repeatPasswordText {
            showAlert(alertMessage: "Please check password match in 'Password' and 'Repeat Password' fields!", viewController: self)
            return false
        }
        
        return true
    }
    
    private func updateCurrentUser() {
        userData.user = User(
            id: userData.user.id,
            login: userData.user.login,
            name: nameText,
            surname: surnameText,
            email: emailText,
            gender: genderText,
            creditCard: creditCardText,
            bio: bioText
        )
    }
    
}

extension UserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
}
