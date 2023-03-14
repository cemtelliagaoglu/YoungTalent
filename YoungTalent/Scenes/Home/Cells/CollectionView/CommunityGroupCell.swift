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
    
    var indexPath: IndexPath?
    var users: [Home.Case.ViewModel.User]?{
        didSet{
            updateView()
        }
    }
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
    
    func updateView(){
        guard let users = self.users else{ return }
        
        if users.count > 4{
            moreMemberView.isHidden = false
            moreMemberLabel.text = "+\(users.count - 3)"
            memberImageView3.isHidden = false
            memberImageView2.isHidden = false
            memberImageView1.isHidden = false
            memberImageView3.downloadImage(with: users[2].profilePhoto)
            memberImageView2.downloadImage(with: users[1].profilePhoto)
            memberImageView1.downloadImage(with: users[0].profilePhoto)
        }else if users.count > 3{
            moreMemberView.isHidden = false
            moreMemberLabel.text = "+1"
            memberImageView3.isHidden = false
            memberImageView2.isHidden = false
            memberImageView1.isHidden = false
            memberImageView3.downloadImage(with: users[2].profilePhoto)
            memberImageView2.downloadImage(with: users[1].profilePhoto)
            memberImageView1.downloadImage(with: users[0].profilePhoto)
        }else if users.count > 2{
            moreMemberView.isHidden = true
            memberImageView3.isHidden = false
            memberImageView2.isHidden = false
            memberImageView1.isHidden = false
            memberImageView3.downloadImage(with: users[2].profilePhoto)
            memberImageView2.downloadImage(with: users[1].profilePhoto)
            memberImageView1.downloadImage(with: users[0].profilePhoto)
        }else if users.count > 1 {
            moreMemberView.isHidden = true
            memberImageView3.isHidden = true
            memberImageView2.isHidden = false
            memberImageView2.downloadImage(with: users[1].profilePhoto)
            memberImageView1.downloadImage(with: users[0].profilePhoto)
        }else if users.count > 0{
            moreMemberView.isHidden = true
            memberImageView3.isHidden = true
            memberImageView2.isHidden = true
            memberImageView1.downloadImage(with: users[0].profilePhoto)
            memberImageView1.isHidden = false
        }else{
            for view in stackView.arrangedSubviews{
                view.isHidden = true
            }
        }
    }
    
    func setGroup(viewModel: Home.Case.ViewModel.GroupModel){
        groupNameLabel.text = viewModel.name
        groupPhotoImageView.downloadImage(with: viewModel.groupPhoto)
        
        if let lastMessage = viewModel.lastMessage{
            let lastMessageAttributedText = NSMutableAttributedString(string: lastMessage.fromUsername + " ",
                                                                      attributes: [
                                                                        .foregroundColor: UIColor(named: "Blue-Dark")!,
                                                                        .font: UIFont(name: "Montserrat-Bold", size: 10)!
                                                                                  ])
            lastMessageAttributedText.append(NSAttributedString(string: lastMessage.message,
                                                                attributes: [
                                                                    .foregroundColor: UIColor(named: "Blue-Light")!,
                                                                    .font: UIFont(name: "Montserrat-Semibold", size: 10)!
                                                                ]))
            lastMessageLabel.attributedText = lastMessageAttributedText
        }
        
        if let users = viewModel.users{
            self.users = users
        }
        
    }
}
