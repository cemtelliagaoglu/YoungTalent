//
//  CommunityGroupCell.swift
//  YoungTalent
//
//  Created by admin on 9.03.2023.
//

import UIKit

class CommunityGroupCell: UICollectionViewCell {
    //MARK: - Properties
    @IBOutlet weak var groupPhotoImageView: UIImageView!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var memberImageView1: UIImageView!
    @IBOutlet weak var memberImageView2: UIImageView!
    @IBOutlet weak var memberImageView3: UIImageView!
    @IBOutlet weak var moreMemberLabel: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
