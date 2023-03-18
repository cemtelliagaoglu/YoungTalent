//
//  ChatViewController.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import UIKit
import PhotosUI

protocol ChatDisplayLogic: AnyObject {
    func displayContact(viewModel: Chat.Case.ViewModel.User)
    func displayErrorMessage(_ errorMessage: String)
}

final class ChatViewController: UIViewController {
    //MARK: - Properties
    private let chatCellIdentifier = "chatCollectionViewCellIdentifier"
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactLoginStatusLabel: UILabel!
    @IBOutlet weak var addMediaButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interactor: ChatBusinessLogic?
    var router: (ChatRoutingLogic & ChatDataPassing)?
    
    var images: [UIImage]?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.fetchData()
        
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
        let interactor = ChatInteractor()
        let presenter = ChatPresenter()
        let router = ChatRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    //MARK: - Handlers
    private func setupView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ChatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: chatCellIdentifier)
    }
    
    private func updateView(images: [UIImage]){
        self.images = images
        
        collectionView.collectionViewLayout = generateCompositionalLayout(imageCount: images.count)
        collectionView.reloadData()
    }
    
    private func generateCompositionalLayout(imageCount: Int) -> UICollectionViewLayout{
        switch imageCount{
        case 1:
            return createCompositionalLayout1()
        case 2:
            return createCompositionalLayout2()
        case 3:
            return createCompositionalLayout3()
        default:
            return createCompositionalLayout4()
        }
    }
    
    private func createCompositionalLayout1() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createCompositionalLayout2() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2),
                                               heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createCompositionalLayout3() -> UICollectionViewLayout{
        let sizeForDouble = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let doubleItems = NSCollectionLayoutItem(layoutSize: sizeForDouble)
        doubleItems.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSizeForDouble = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                        heightDimension: .fractionalHeight(1 / 2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSizeForDouble,
                                                       repeatingSubitem: doubleItems,
                                                       count: 2)
        
        let sizeForSingle = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 2))
        let singleItem = NSCollectionLayoutItem(layoutSize: sizeForSingle)
        singleItem.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
                                                         subitems: [group,singleItem])
    
        let section = NSCollectionLayoutSection(group: mainGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createCompositionalLayout4() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                               heightDimension: .fractionalHeight(1/2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @IBAction func addMediaButtonPressed(_ sender: UIButton) {
        router?.routeToPHPicker()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        router?.popVC()
    }
}
//MARK: - PHPickerDelegate
extension ChatViewController: PHPickerViewControllerDelegate{
    
 func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
     picker.dismiss(animated: true)
        var selectedImages: [UIImage] = []
        
        let group = DispatchGroup()
        
        for result in results {
            group.enter()
            if result.itemProvider.canLoadObject(ofClass: UIImage.self){
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let image = object as? UIImage{
                        selectedImages.append(image)
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.updateView(images: selectedImages)
        }
    }
}
//MARK: - CollectionView Methods
extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let imageCount = self.images?.count else{ return 0 }
        return imageCount >  4 ? 4: imageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellIdentifier, for: indexPath) as? ChatCollectionViewCell else{ return UICollectionViewCell() }
        guard let images = self.images else{ return cell }
        
        cell.morePhotosView.isHidden = true
        
        if indexPath.item == 3 && images.count > 4{
            cell.morePhotosView.isHidden = false
            cell.morePhotosLabel.text = "+\(images.count - 3)"
        }
        cell.selectedImageView.image = images[indexPath.item]
        return cell
    }
}
//MARK: - DisplayLogic
extension ChatViewController: ChatDisplayLogic {
    func displayContact(viewModel: Chat.Case.ViewModel.User) {
        contactNameLabel.text = viewModel.fullName
        contactImageView.downloadImage(with: viewModel.profilePhoto)
    }
    
    func displayErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
