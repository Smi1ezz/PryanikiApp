//
//  SoundTableViewCell.swift
//  pryanikyTestApp
//
//  Created by admin on 27.08.2022.
//
import Foundation
import UIKit

class AudioTableViewCell: UITableViewCell {
    private let audioNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let coverImg: UIImageView = {
       let img = UIImageView()
       return img
    }()
    
    private let playerView: UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWithData(data: PictureResponse) {
        audioNameLabel.text = data.text
    }
    
    func setupWithImg(_ img: UIImage?) {
        guard let image = img else {
            return
        }
        coverImg.image = image
    }
    
    func play(fromUrl url: String?) {
        
    }
    
    func stop() {
        
    }
    
    private func setupSubviews() {
        [audioNameLabel, coverImg, playerView].forEach { item in
            contentView.addSubview(item)
        }
        playerView.backgroundColor = .gray
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
        
    }
}
