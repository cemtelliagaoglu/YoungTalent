//
//  HomeVC.swift
//  YoungTalent
//
//  Created by admin on 9.03.2023.
//

import UIKit

class HomeVC: UIViewController{
    //MARK: - Properties
    private let tableViewCellIdentifier = "chatCellIdentifier"
    private let collectionViewCellIdentifier = "communityMainCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - Handlers
    func setupView(){
        // collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CommunityMainCell", bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
        
        // tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 75
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
}
