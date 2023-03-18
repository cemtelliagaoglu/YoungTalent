//
//  ChatCollectionViewCell.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var morePhotosView: UIView!
    @IBOutlet weak var morePhotosLabel: UILabel!
   
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}
