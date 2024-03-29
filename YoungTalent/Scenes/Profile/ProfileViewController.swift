//
//  ProfileViewController.swift
//  YoungTalent
//
//  Created by admin on 27.03.2023.
//

import CommonUI
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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var doneButton: CommonButton!
    @IBOutlet var backButton: CommonButton!

    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?

    private let genders = ["Male", "Female"]
    private var viewModel: Profile.Case.ViewModel? {
        didSet {
            updateView()
        }
    }

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

    // MARK: - Handlers

    private func setupView() {
        backButton.setButton(image: UIImage(named: "back"))
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        datePicker.addTarget(self, action: #selector(dateDidSelect), for: .valueChanged)
        setupWebView()
        configureToolbar()
        doneButton.isHidden = true
    }

    private func setupWebView() {
        webView.navigationDelegate = self
        guard let url = URL(string: "https://www.linkedin.com/in/cem-telliagaoglu/") else { return }

        DispatchQueue.main.async { [weak self] in
            self?.webView.load(URLRequest(url: url))
            self?.webView.allowsBackForwardNavigationGestures = true
        }
    }

    private func updateView() {
        guard let viewModel else { return }
        let genderRow = viewModel.gender == "Male" ? 0 : 1
        genderPickerView.selectRow(genderRow, inComponent: 0, animated: false)
        datePicker.date = viewModel.dateOfBirth
    }

    private func configureToolbar() {
        navigationController?.isToolbarHidden = false

        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: webView,
            action: #selector(webView.reload)
        )
        refreshButton.tintColor = UIColor(named: "Blue-Dark")
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: webView,
            action: #selector(webView.goBack)
        )
        backButton.tintColor = UIColor(named: "Blue-Dark")
        let forwardButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.forward"),
            style: .plain,
            target: webView,
            action: #selector(webView.goForward)
        )
        forwardButton.tintColor = UIColor(named: "Blue-Dark")

        toolbarItems = [refreshButton, backButton, forwardButton]
    }

    @IBAction func doneButtonPressed(_ sender: CommonButton) {
        let gender = genders[genderPickerView.selectedRow(inComponent: 0)]
        let date = datePicker.date
        interactor?.saveProfile(dateOfBirth: date, gender: gender)
        doneButton.isHidden = true
    }

    @IBAction func backButtonPressed(_ sender: CommonButton) {
        router?.popViewController()
    }

    @objc private func dateDidSelect() {
        doneButton.isHidden = datePicker.date == viewModel?.dateOfBirth ? true : false
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
        doneButton.isHidden = genders[row] == viewModel?.gender ? true : false
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
        self.viewModel = viewModel
    }

    func displayErrorMessage(_ errorMessage: String) {
        router?.showAlert(title: "Error", message: errorMessage)
    }
}

// MARK: - WebView

extension ProfileViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        if url.scheme == "mailto" || url.scheme == "tel" {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        } else {
            if url.host == "www.linkedin.com" {
                decisionHandler(.allow)
            } else {
                decisionHandler(.cancel)
            }
        }
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
