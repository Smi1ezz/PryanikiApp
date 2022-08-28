//
//  PictureTableViewCell.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    private let imgLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let cellImg: UIImageView = {
       let img = UIImageView()
       return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWithData(data: PictureResponse) {
        imgLabel.text = data.text
    }

    func setupWithImg(_ img: UIImage?) {
        guard let image = img else {
            return
        }
        cellImg.image = image
    }

    private func setupSubviews() {
        [imgLabel, cellImg].forEach { item in
            contentView.addSubview(item)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        imgLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
        }

        cellImg.snp.makeConstraints { make in
            make.top.equalTo(imgLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(250)
            make.width.equalTo(250)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }

    }

}
