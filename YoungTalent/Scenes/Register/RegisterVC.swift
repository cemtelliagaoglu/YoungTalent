//
//  RegisterVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import CommonUI
import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func setupView()
}

class RegisterVC: UIViewController {
    // MARK: - Properties

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var nextButton: CommonButton!
    @IBOutlet var backButton: CommonButton!

    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.notifyViewDidLoad()
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
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    @objc func hideKeyboard() {
        nameTextField.endEditing(true)
    }

    @IBAction func nextButtonPressed(_ sender: CommonButton) {
        router?.routeToHome()
    }

    @IBAction func backButtonPressed(_ sender: CommonButton) {
        router?.popVC()
    }
}

// MARK: - TextFieldDelegate

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nextButtonPressed(nextButton)
        return false
    }
}

// MARK: - DisplayLogic

extension RegisterVC: RegisterDisplayLogic {
    func setupView() {
        backButton.setButton(image: UIImage(named: "back"))
        // nameTextField
        nameTextField.delegate = self
        // hideKeyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
}
