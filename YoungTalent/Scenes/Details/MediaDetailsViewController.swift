//
//  MediaDetailsViewController.swift
//  YoungTalent
//
//  Created by admin on 3.04.2023.
//

import AVFoundation
import UIKit

class MediaDetailsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var videoView: UIView!
    @IBOutlet var playerView: UIView!
    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var rewindButton: UIButton!
    @IBOutlet var fastForwardButton: UIButton!
    @IBOutlet var increaseSoundButton: UIButton!
    @IBOutlet var decreaseSoundButton: UIButton!
    @IBOutlet var videoTimeLabel: UILabel!
    @IBOutlet var videoControlStackView: UIStackView!
    @IBOutlet var videoDurationView: UIView!
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    var viewingMode: ViewingMode?
    private var isPlaying: Bool = false
    private lazy var videoSupplementaryViews: [UIView] = [
        backButton, videoDurationView, videoControlStackView
    ]

    enum ViewingMode {
        case image
        case video
    }

    var index: Int = 0
    var image: UIImage?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = playerView.bounds
    }

    // MARK: - Handlers

    private func setupView() {
        guard let viewingMode else {
            displayError(title: "viewingMode found nil!", message: "")
            return
        }
        switch viewingMode {
        case .image:
            guard let image else { return }
            videoView.isHidden = true
            imageView.isHidden = false
            imageView.image = image
        case .video:
            imageView.isHidden = true
            videoView.isHidden = false
            setupVideoView()
        }
    }

    private func setupVideoView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSupplementaryViews))
        view.addGestureRecognizer(tap)
        let videoURL = URL(
            fileURLWithPath: Bundle.main.path(
                forResource: "testVideo",
                ofType: "mp4"
            )!
        )
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resize
        guard let playerLayer else { return }
        videoView.layer.addSublayer(playerLayer)
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        guard let current = player?.currentItem else { return }
        _ = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] _ in
            self?.timeSlider.maximumValue = Float(current.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(current.currentTime().seconds)
            self?.videoTimeLabel.text = "\(current.currentTime().durationText) / \(current.duration.durationText)"
        })
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: current,
            queue: .main
        ) { [weak self] _ in
            self?.playButton.setTitle("Play", for: .normal)
            self?.isPlaying = false
            self?.player?.seek(to: .zero)
        }
    }

    @objc private func toggleSupplementaryViews() {
        videoSupplementaryViews.forEach { view in
            view.isHidden.toggle()
        }
        videoView.layoutIfNeeded()
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
        let buttonText = !isPlaying ? "Play" : "Pause"
        sender.setTitle(buttonText, for: .normal)
    }

    @IBAction func backForwardPressed(_ sender: UIButton) {
        guard let player,
              let videoDuration = player.currentItem?.duration
        else { return }

        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = sender == fastForwardButton ? currentTime + 10 : currentTime - 10

        if newTime < CMTimeGetSeconds(videoDuration) || newTime > 0 {
            let time = CMTimeMake(
                value: Int64(newTime * 1000),
                timescale: 1000
            )
            player.seek(to: time)
        }
    }

    @IBAction func timeSliderChangedValue(_ sender: UISlider) {
        player?.seek(to: CMTimeMake(value: Int64(sender.value * 1000), timescale: 1000))
    }

    @IBAction func changeSoundPressed(_ sender: UIButton) {
        guard let player else { return }
        if sender == decreaseSoundButton, player.volume > 0 {
            player.volume -= 0.1
        } else if sender == increaseSoundButton, player.volume < 1 {
            player.volume += 0.1
        }
        print("Player Volume:", player.volume)
    }

    private func displayError(title: String, message: String) {
        presentAlert(title: title, message: message)
        navigationController?.popViewController(animated: true)
    }
}
