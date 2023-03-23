//
//  ChatTableViewCell.swift
//  YoungTalent
//
//  Created by admin on 9.03.2023.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    // MARK: - Properties

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var categoryColorView: UIView!

    var userViewModel: Home.Case.ViewModel.User? {
        didSet {
            updateView()
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Handler

    func setViewModel(viewModel: Home.Case.ViewModel.User) {
        userViewModel = viewModel
    }

    func updateView() {
        guard let viewModel = userViewModel else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.fullName
            self.profileImageView.downloadImage(with: viewModel.profilePhoto)
        }
    }
}
