//
//  MediaDetailsViewController.swift
//  YoungTalent
//
//  Created by admin on 3.04.2023.
//

import UIKit

class MediaDetailsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var imageView: UIImageView!
    var index: Int = 0
    var image: UIImage?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        guard let image else { return }
        imageView.image = image
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
