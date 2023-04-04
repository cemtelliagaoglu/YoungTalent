//
//  MediaPageViewController.swift
//  YoungTalent
//
//  Created by admin on 3.04.2023.
//

import UIKit

class MediaPageViewController: UIPageViewController {
    // MARK: - Properties

    var images: [UIImage]?
    var mediaViewControllers: [UIViewController]? {
        didSet {
            setupFlow()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        delegate = self
        dataSource = self
        guard let images else { return }
        var mediaViewControllers = [UIViewController]()
        for index in 0 ..< images.count {
            let viewController = createViewController(with: images[index], index: index)
            mediaViewControllers.append(viewController)
        }
        self.mediaViewControllers = mediaViewControllers
    }

    private func setupFlow() {
        if let firstVC = mediaViewControllers?.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }

    private func createViewController(with image: UIImage, index: Int) -> MediaDetailsViewController {
        let viewController = MediaDetailsViewController()
        viewController.index = index
        viewController.image = image
        return viewController
    }
}

extension MediaPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentViewController = viewController as? MediaDetailsViewController
        else { return nil }
        let currentIndex = currentViewController.index
        if currentIndex > 0 {
            return mediaViewControllers?[currentIndex - 1]
        }
        return nil
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentViewController = viewController as? MediaDetailsViewController,
              let numberOfViewControllers = mediaViewControllers?.count
        else { return nil }
        let currentIndex = currentViewController.index
        if currentIndex < numberOfViewControllers - 1 {
            return mediaViewControllers?[currentIndex + 1]
        }
        return nil
    }
}
