//
//  CommunityMainCell.swift
//  YoungTalent
//
//  Created by admin on 9.03.2023.
//

import UIKit

class CommunityMainCell: UICollectionViewCell {
    // MARK: - Properties

    private let cellIdentifier = "cellIdentifier"

    @IBOutlet var notAMemberLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    var groupViewModels: [Home.Case.ViewModel.GroupModel]? {
        didSet {
            guard let models = groupViewModels else {
                notAMemberLabel.isHidden = false
                return
            }
            if models.isEmpty {
                notAMemberLabel.isHidden = false
            } else {
                notAMemberLabel.isHidden = true
            }
            collectionView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "CommunityGroupCell", bundle: nil),
            forCellWithReuseIdentifier: cellIdentifier
        )
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - CollectionView Methods

extension CommunityMainCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        groupViewModels?.count ?? 0
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt _: Int
    ) -> CGFloat {
        10
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CommunityGroupCell
        else { return UICollectionViewCell() }
        guard let model = groupViewModels?[indexPath.row] else { return cell }
        cell.setGroup(viewModel: model)
        return cell
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        CGSize(width: 210, height: 134)
    }
}
