//
//  OTPVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

protocol OTPDisplayLogic: AnyObject {
    func displayErrorMessage(_ errorMessage: String)
    func displaySuccess()
}

class OTPVC: UIViewController {
    // MARK: - Properties

    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var textField3: UITextField!
    @IBOutlet var textField4: UITextField!

    var interactor: OTPBusinessLogic?
    var router: (OTPRoutingLogic & OTPDataPassing)?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextFields()
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = OTPInteractor()
        let presenter = OTPPresenter()
        let router = OTPRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Handlers

    func setupTextFields() {
        textField1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    func setupView() {
        // keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        textField1.endEditing(true)
        textField2.endEditing(true)
        textField3.endEditing(true)
        textField4.endEditing(true)
    }

    @objc func textDidChange(_ textField: UITextField) {
        if textField.text!.count == 1 {
            switch textField {
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            default:
                textField4.resignFirstResponder()
            }
        } else {
            switch textField {
            case textField4:
                textField3.becomeFirstResponder()
            case textField3:
                textField2.becomeFirstResponder()
            case textField2:
                textField1.becomeFirstResponder()
            case textField1:
                textField1.resignFirstResponder()
            default:
                break
            }
        }
    }

    @IBAction func handleBackButtonTapped(_: UIButton) {
        router?.popVC()
    }

    @IBAction func handleNextButtonTapped(_: UIButton) {
        guard textField1.hasText,
              textField2.hasText,
              textField3.hasText,
              textField4.hasText else { return }

        let otpCode = "\(textField1.text!)\(textField2.text!)\(textField3.text!)\(textField4.text!)"
        print("Next Button Tapped... OTP Code: \(otpCode)")
        interactor?.verifyOTP(otpCode)
    }
}

// MARK: - DisplayLogic

extension OTPVC: OTPDisplayLogic {
    func displaySuccess() {
        router?.routeToHome()
    }

    func displayErrorMessage(_ errorMessage: String) {
        presentAlert(title: "Error", message: errorMessage)
    }
}
