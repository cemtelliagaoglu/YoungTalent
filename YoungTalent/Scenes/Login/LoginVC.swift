//
//  LoginVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayLogin()
    func displayErrorMessage(_ errorMessage: String)
    func displayLoadingAnimation()
    func stopLoadingAnimation()
}

class LoginVC: UIViewController {
    // MARK: - Properties

    @IBOutlet var termsAndConditionLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Handlers

    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // hideKeyboard
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTap)
        // setup termsAndConditionLabel
        let attributedText = NSMutableAttributedString(
            string: "By click login you are agree with\nour",
            attributes: [
                .foregroundColor: UIColor(named: "Blue-Light")!,
                .font: UIFont(name: "Montserrat-Regular", size: 10)!
            ]
        )
        attributedText.append(NSAttributedString(
            string: " Terms and Condition",
            attributes: [
                .foregroundColor: UIColor(named: "Purple-Gradient")!,
                .font: UIFont(name: "Montserrat-Bold", size: 10)!
            ]
        ))
        termsAndConditionLabel.attributedText = attributedText

        let labelTap = UITapGestureRecognizer(target: self, action: #selector(handleTermsAndConditionTapped))
        labelTap.numberOfTapsRequired = 1
        termsAndConditionLabel.addGestureRecognizer(labelTap)
    }

    @objc func handleTermsAndConditionTapped() {
        print("Terms And Condition Tapped")
    }

    @objc func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @IBAction func loginButtonTapped(_: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              passwordTextField.hasText,
              emailTextField.hasText
        else {
            displayErrorMessage("Missing Email/Password")
            return
        }
        displayLoadingAnimation()
        interactor?.requestLoginWith(email, password)
    }

    @IBAction func backButtonTapped(_: UIButton) {
        router?.popVC()
    }
}

// MARK: - TextFieldDelegate

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            loginButtonTapped(loginButton)
        default:
            textField.resignFirstResponder()
        }
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - DisplayLogic

extension LoginVC: LoginDisplayLogic {
    func displayLogin() {
        router?.routeToHome()
    }

    func displayErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

    func displayLoadingAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.loginButton.isUserInteractionEnabled = false
        }
    }

    func stopLoadingAnimation() {
        DispatchQueue.main.async {
            self.loginButton.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }
}
