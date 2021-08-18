//
//  LoginViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 20.06.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    private let userData = UserData.instance
    private var spinner = UIActivityIndicatorView()
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.layer.cornerRadius = usernameTextField.frame.size.height / 2
            usernameTextField.layer.borderWidth = 0.5
            usernameTextField.layer.borderColor = UIColor.systemGray2.cgColor
            usernameTextField.layer.masksToBounds = true
            usernameTextField.tag = 1
            usernameTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height / 2
            passwordTextField.layer.borderWidth = 0.5
            passwordTextField.layer.borderColor = UIColor.systemGray2.cgColor
            passwordTextField.layer.masksToBounds = true
            passwordTextField.tag = 2
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        }
    }
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        goToRegister()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        login()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        userData.user = User()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Segues
    
    @IBAction func unwindFromRegister (_ segue: UIStoryboardSegue) {
        cleanLoginData()
    }
    
    @IBAction func unwindFromUserInfo (_ segue: UIStoryboardSegue) {
        cleanLoginData()
    }
    
    // MARK: - Auth Methods
    
    private func authLogin(login: String, password: String, cookie: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(loginName: login, password: password, cookie: cookie) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let login):
                    logging(login)
                    if login.result == 1 {
                        logAnalytics(messageType: .loginSuccessful, messageText: "User logged successfully")
                        self.userData.user = login.user
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                        mainTabBarController.modalPresentationStyle = .fullScreen
                        mainTabBarController.modalTransitionStyle = .flipHorizontal
                        self.deactivateSpinner()
                        self.present(mainTabBarController, animated: true, completion: nil)
                    } else {
                        logAnalytics(messageType: .loginUnsuccessful, messageText: "Wrong user credentials")
                        showAlert(alertMessage: "Wrong credentials!", viewController: self)
                        self.deactivateSpinner()
                    }
                case .failure(let error):
                    logging(error.localizedDescription)
                    showAlert(alertMessage: "Wrong server response!", viewController: self)
                    self.deactivateSpinner()
                }
            }
        }
    }
    
    // MARK: - App Logic
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
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
    
    private func goToRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerViewController = storyboard.instantiateViewController(identifier: "RegisterViewController")
        registerViewController.modalPresentationStyle = .fullScreen
        present(registerViewController, animated: true, completion: nil)
    }
    
    private func cleanLoginData() {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func login() {
        guard
            let loginText = usernameTextField.text?.trimmingCharacters(in: [" "]),
            let passwordText = passwordTextField.text
        else {
            showAlert(alertMessage: "All fields must be filled out!", viewController: self)
            return
        }
        
        if loginText.isEmpty || passwordText.isEmpty {
            showAlert(alertMessage: "All fields must be filled out!", viewController: self)
            return
        }
        activateSpinner()
        authLogin(login: loginText, password: passwordText, cookie: "")
    }
    
    func activateSpinner() {
        loginButton.isHidden = true
        registerButton.isHidden = true
        
        spinner.style = .large
        spinner.color = .systemGray2
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([spinner.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
                                     spinner.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor)])
        
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            self.deactivateSpinner()
        }
    }
    
    func deactivateSpinner() {
        loginButton.isHidden = false
        registerButton.isHidden = false
        spinner.stopAnimating()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == passwordTextField.tag {
            login()
            return true
        }
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
}
