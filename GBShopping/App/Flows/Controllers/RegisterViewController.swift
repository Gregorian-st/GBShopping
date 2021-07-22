//
//  RegisterViewController.swift
//  GBShopping
//
//  Created by Grigory Stolyarov on 12.07.2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private var loginText = String()
    private var passwordText = String()
    private var repeatPasswordText = String()
    private var nameText = String()
    private var surnameText = String()
    private var genderText = String()
    private var emailText = String()
    private var creditCardText = String()
    private var bioText = String()
    private let requestFactory = RequestFactory()
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            loginTextField.tag = 1
            loginTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tag = 2
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var repeatPasswordTextField: UITextField! {
        didSet {
            repeatPasswordTextField.tag = 3
            repeatPasswordTextField.delegate = self
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.tag = 4
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var surnameTextField: UITextField! {
        didSet {
            surnameTextField.tag = 5
            surnameTextField.delegate = self
        }
    }
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.tag = 6
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var creditCardTextField: UITextField! {
        didSet {
            creditCardTextField.tag = 7
            creditCardTextField.delegate = self
        }
    }
    @IBOutlet weak var bioTextField: UITextField! {
        didSet {
            bioTextField.tag = 8
            bioTextField.delegate = self
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.layer.cornerRadius = registerButton.frame.size.height / 2
        }
    }
    
    // MARK: - Actions
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        register()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Auth Methods
    
    private func authRegisterUser(loginName: String,
                                  password: String,
                                  name: String,
                                  surname: String,
                                  email: String,
                                  gender: String,
                                  creditCard: String,
                                  bio: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.registerUser(loginName: loginName,
                          password: password,
                          name: name,
                          surname: surname,
                          email: email,
                          gender: gender,
                          creditCard: creditCard,
                          bio: bio) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let registerUser):
                    logging(registerUser)
                    if registerUser.result == 1 {
                        self.performSegue(withIdentifier: "unwindFromRegister", sender: self)
                    } else {
                        showAlert(alertMessage: "Wrong field content!", viewController: self)
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
    
    private func register() {
        if validateRegistrationInfo() {
            authRegisterUser(loginName: loginText,
                             password: passwordText,
                             name: nameText,
                             surname: surnameText,
                             email: emailText,
                             gender: genderText,
                             creditCard: creditCardText,
                             bio: bioText)
        }
    }
    
    private func validateRegistrationInfo() -> Bool {
        loginText = loginTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        passwordText = passwordTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        repeatPasswordText = repeatPasswordTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        nameText = nameTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        surnameText = surnameTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        genderText = genderSegmentedControl.selectedSegmentIndex == 0 ? "M" : "F"
        emailText = emailTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        creditCardText = creditCardTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        bioText = bioTextField.text?.trimmingCharacters(in: [" "]) ?? ""
        
        if loginText.isEmpty ||
            passwordText.isEmpty ||
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
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
}
