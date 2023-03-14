//
//  CommunityMainCell.swift
//  YoungTalent
//
//  Created by admin on 9.03.2023.
//

import UIKit

class CommunityMainCell: UICollectionViewCell {
    //MARK: - Properties
    private let cellIdentifier = "cellIdentifier"
    
    @IBOutlet weak var notAMemberLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groupViewModels: [Home.Case.ViewModel.GroupModel]?{
        didSet{
            guard let models = groupViewModels else{
                notAMemberLabel.isHidden = false
                return
            }
            if models.isEmpty{
                notAMemberLabel.isHidden = false
            }else{
                notAMemberLabel.isHidden = true
            }
            collectionView.reloadData()
        }
    }
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CommunityGroupCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
}

//MARK: - CollectionView Methods
extension CommunityMainCell: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupViewModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CommunityGroupCell else{ return UICollectionViewCell()}
        guard let model = groupViewModels?[indexPath.row] else{ return cell}
        cell.setGroup(viewModel: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 134)
    }
}
