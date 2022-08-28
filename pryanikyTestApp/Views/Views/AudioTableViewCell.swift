//
//  SoundTableViewCell.swift
//  pryanikyTestApp
//
//  Created by admin on 27.08.2022.
//
import Foundation
import UIKit
import AVKit
import AVFoundation

class AudioTableViewCell: UITableViewCell, Controllable {
    private let audioNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let coverImg: UIImageView = {
       let img = UIImageView()
       return img
    }()

    private let playerView = PlayerView()

    private let playButton: UIButton = {
        let playButton = UIButton()
        playButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        playButton.tintColor = .blue
        return playButton
    }()

    private var mediaURL: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithData(data: AudioResponse) {
        audioNameLabel.text = data.text
        mediaURL = data.mediaUrl
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
    }

    func setupWithImg(_ img: UIImage?) {
        guard let image = img else {
            return
        }
        coverImg.image = image
    }

    @objc
    func play() {
        guard let mediaURL = mediaURL else {
            return
        }

        let urlFromString = URL(string: mediaURL)

        guard let url = urlFromString else {
            return
        }

        let avPlayer = AVPlayer(url: url)
        playerView.playerLayer.player = avPlayer
        playerView.player?.play()
        playButton.isHidden = true

    }

    @objc
    func stop() {
        playerView.player?.pause()
        playerView.player = nil
        playButton.isHidden = false

    }

    private func setupSubviews() {
        [audioNameLabel, coverImg, playerView, playButton].forEach { item in
            contentView.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        audioNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
        }

        coverImg.snp.makeConstraints { make in
            make.top.equalTo(audioNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }

        playerView.snp.makeConstraints { make in
            make.top.equalTo(coverImg.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(30)
            make.width.equalTo(250)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }

        playButton.snp.makeConstraints { make in
            make.center.equalTo(playerView.snp.center)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
}
