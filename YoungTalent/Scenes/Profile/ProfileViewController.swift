//
//  ProfileViewController.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import UIKit
import WebKit

protocol ProfileDisplayLogic: AnyObject {
    func displayUserProfile(viewModel: Profile.Case.ViewModel)
    func displayErrorMessage(_ errorMessage: String)
}

final class ProfileViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var genderPickerView: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var doneButton: UIButton!

    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?

    private let genders = ["Male", "Female"]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.loadUserProfile()
    }

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
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupView() {
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        datePicker.addTarget(self, action: #selector(dateDidSelect), for: .valueChanged)
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        print("Date: \(datePicker.date) \nGender: \(genders[genderPickerView.selectedRow(inComponent: 0)])")
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        router?.popViewController()
    }

    @objc private func dateDidSelect() {
        interactor?.saveDate(datePicker.date)
        dismiss(animated: true)
    }
}

// MARK: - PickerView Methods

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        interactor?.saveGender(genders[row])
    }

    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Semibold", size: 14)
        label.textAlignment = .center
        label.textColor = UIColor(named: "Blue-Light")
        label.text = genders[row]
        return label
    }
}

// MARK: - DisplayLogic

extension ProfileViewController: ProfileDisplayLogic {
    func displayUserProfile(viewModel: Profile.Case.ViewModel) {
        let genderRow = viewModel.gender == "Male" ? 0 : 1
        genderPickerView.selectRow(genderRow, inComponent: 0, animated: false)
        datePicker.date = viewModel.dateOfBirth
    }

    func displayErrorMessage(_ errorMessage: String) {
        router?.showAlert(title: "Error", message: errorMessage)
    }
}
