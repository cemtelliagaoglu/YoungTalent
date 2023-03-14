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
    func displayErrorMessage(_ errorMessage: String)
}

final class HomeVC: UIViewController{
    //MARK: - Properties
    private let tableViewCellIdentifier = "chatCellIdentifier"
    private let collectionViewCellIdentifier = "communityMainCellIdentifier"
    private let collectionViewHeaderIdentifier = "communityHeaderIdentifier"
    
    @IBOutlet weak var currentUserProfileImageView: UIImageView!
    @IBOutlet weak var currentUserNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    var groupsViewModel: [Home.Case.ViewModel.GroupModel]?
    var currentUserViewModel: Home.Case.ViewModel.User?{
        didSet{
            updateCurrentUserModel()
        }
    }
    //MARK: - Lifecycle
    
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
    
    //MARK: - Handlers
    func setupView(){
        // collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CommunityMainCell", bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView.register(CommunityHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderIdentifier)
        
        // tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 75
    }
    
    func updateCurrentUserModel(){
        guard let currentUserViewModel = self.currentUserViewModel else{ return }
        let titleText = currentUserViewModel.title != nil ? "(\(currentUserViewModel.title!)": ""
        DispatchQueue.main.async {
            self.currentUserNameLabel.text = "\(currentUserViewModel.nameSurname) \(titleText)"
            self.currentUserProfileImageView.downloadImage(with: currentUserViewModel.profilePhoto)
        }
    }
}
//MARK: - TableView Methods

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? ChatTableViewCell else{ return UITableViewCell() }
        
        return cell
    }
}
//MARK: - CollectionView Methods
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as? CommunityMainCell else{ return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 165)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderIdentifier, for: indexPath) as? CommunityHeader else{ return UICollectionReusableView() }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 16)
    }
}
//MARK: - HomeDisplayLogic
extension HomeVC: HomeDisplayLogic{
    
    func setCurrentUser(userViewModel: Home.Case.ViewModel.User) {
        self.currentUserViewModel = userViewModel
    }
    func displayGroups(groupViewModels: [Home.Case.ViewModel.GroupModel]) {
        DispatchQueue.main.async {
            let cell = self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! CommunityMainCell
            cell.groupViewModels = groupViewModels
        }
    }
    func displayErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}
