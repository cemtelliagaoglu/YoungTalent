//
//  WelcomeVC.swift
//  YoungTalent
//
//  Created by admin on 2.03.2023.
//

import UIKit

protocol WelcomeDisplayLogic: AnyObject {
    func setupView(isDarkMode: Bool)
    func updateView(isDarkMode: Bool)
}

final class WelcomeVC: UIViewController {
    // MARK: - Properties

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerLabel: UILabel!
    @IBOutlet var darkModeSwitch: UISwitch!

    var interactor: WelcomeBusinessLogic?
    var router: (WelcomeRoutingLogic & WelcomeDataPassing)?

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
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter()
        let router = WelcomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    @IBAction func loginButtonTapped(_: UIButton) {
        router?.routeToLogin()
    }

    @objc func handleRegisterTapped() {
        router?.routeToRegister()
    }

    @IBAction func darkModeSwitched(_ sender: UISwitch) {
        interactor?.switchDarkMode(newValue: sender.isOn)
    }
}

// MARK: - DisplayLogic

extension WelcomeVC: WelcomeDisplayLogic {
    func setupView(isDarkMode: Bool) {
        // registerLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleRegisterTapped))
        registerLabel.addGestureRecognizer(tap)
        // set darkModeSwitch
        darkModeSwitch.isOn = isDarkMode
    }

    func updateView(isDarkMode: Bool) {
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
