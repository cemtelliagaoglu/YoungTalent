//
//  ChatCollectionViewCell.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var morePhotosView: UIView!
    @IBOutlet var morePhotosLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
