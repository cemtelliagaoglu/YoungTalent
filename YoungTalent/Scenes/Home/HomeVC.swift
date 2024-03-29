//
//  HomeVC.swift
//  YoungTalent
//
//  Created by admin on 9.03.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayGroups(groupViewModels: [Home.Case.ViewModel.GroupModel])
    func setCurrentUser(userViewModel: Home.Case.ViewModel.User)
    func displayUsers(userViewModels: [Home.Case.ViewModel.User])
    func displayLogout()
    func displayNewTheme(_ isDarkMode: Bool)
    func displayErrorMessage(_ errorMessage: String)
}

final class HomeVC: UIViewController {
    // MARK: - Properties

    private let tableViewCellIdentifier = "chatCellIdentifier"
    private let collectionViewCellIdentifier = "communityMainCellIdentifier"
    private let collectionViewHeaderIdentifier = "communityHeaderIdentifier"

    @IBOutlet var currentUserProfileImageView: UIImageView!
    @IBOutlet var currentUserNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var settingsView: UIView!

    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?

    var groupsViewModel: [Home.Case.ViewModel.GroupModel]?
    var usersViewModel: [Home.Case.ViewModel.User]?
    var currentUserViewModel: Home.Case.ViewModel.User?

    lazy var viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleSettingsView))

    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.fetchData()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - Handlers

    private func setupView() {
        viewGestureRecognizer.isEnabled = false
        view.addGestureRecognizer(viewGestureRecognizer)
        // collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "CommunityMainCell", bundle: nil),
            forCellWithReuseIdentifier: collectionViewCellIdentifier
        )
        collectionView.register(
            CommunityHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: collectionViewHeaderIdentifier
        )

        // tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ChatTableViewCell", bundle: nil),
            forCellReuseIdentifier: tableViewCellIdentifier
        )
        tableView.separatorStyle = .none
        tableView.rowHeight = 75
        // currentUser
        guard let currentUserViewModel else { return }

        DispatchQueue.main.async {
            self.currentUserNameLabel.text = currentUserViewModel.fullName
            self.currentUserProfileImageView.downloadImage(with: currentUserViewModel.profilePhoto)
        }
        currentUserProfileImageView.addGestureRecognizer(createProfileGesture())
        currentUserNameLabel.addGestureRecognizer(createProfileGesture())
    }

    private func createProfileGesture() -> UITapGestureRecognizer {
        let profileTap = UITapGestureRecognizer()
        profileTap.addTarget(self, action: #selector(handleProfileTapped))
        return profileTap
    }

    @objc private func toggleSettingsView() {
        viewGestureRecognizer.isEnabled = false
        settingsView.hideAnimation(isHidden: true)
    }

    @objc private func handleProfileTapped() {
        settingsView.hideAnimation(isHidden: false)
        viewGestureRecognizer.isEnabled = true
    }

    @IBAction func profileButtonPressed(_ sender: UIButton) {
        router?.routeToProfile()
    }

    @IBAction func switchThemePressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.interactor?.switchTheme()
        }
    }

    @IBAction func logoutPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.activityIndicator.startAnimating()
            self?.interactor?.requestLogout()
        })
        present(alert, animated: true)
    }
}

// MARK: - TableView Methods

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        usersViewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? ChatTableViewCell
        else { return UITableViewCell() }
        guard let userViewModel = usersViewModel?[indexPath.row] else { return cell }
        cell.setViewModel(viewModel: userViewModel)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToChat(index: indexPath.row)
    }
}

// MARK: - CollectionView Methods

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: collectionViewCellIdentifier,
            for: indexPath
        ) as? CommunityMainCell else { return UICollectionViewCell() }

        return cell
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.size.width, height: 165)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind _: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: collectionViewHeaderIdentifier,
            for: indexPath
        ) as? CommunityHeader else { return UICollectionReusableView() }
        return header
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        referenceSizeForHeaderInSection _: Int
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.size.width, height: 16)
    }
}

// MARK: - HomeDisplayLogic

extension HomeVC: HomeDisplayLogic {
    func setCurrentUser(userViewModel: Home.Case.ViewModel.User) {
        currentUserViewModel = userViewModel
    }

    func displayGroups(groupViewModels: [Home.Case.ViewModel.GroupModel]) {
        DispatchQueue.main.async {
            guard let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? CommunityMainCell
            else { return }
            cell.groupViewModels = groupViewModels
        }
    }

    func displayUsers(userViewModels: [Home.Case.ViewModel.User]) {
        usersViewModel = userViewModels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayLogout() {
        activityIndicator.stopAnimating()
        router?.popToRoot()
    }

    func displayNewTheme(_ isDarkMode: Bool) {
        activityIndicator.stopAnimating()
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?
            .windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }

    func displayErrorMessage(_ errorMessage: String) {
        presentAlert(title: "Error", message: errorMessage)
    }
}
