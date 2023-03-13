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
    @IBOutlet weak var moreMemberView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else{ return }
        memberImageView1.layer.borderColor = UIColor(named: "backgroundColor")!.cgColor
        memberImageView2.layer.borderColor = UIColor(named: "backgroundColor")!.cgColor
        memberImageView3.layer.borderColor = UIColor(named: "backgroundColor")!.cgColor
    }
    
    func setupView(){
        stackView.bringSubviewToFront(memberImageView3)
        stackView.bringSubviewToFront(memberImageView2)
        stackView.bringSubviewToFront(memberImageView1)
    }
    
}
