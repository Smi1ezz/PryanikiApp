//
//  TextOnlyTableViewCell.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import UIKit

class TextOnlyTableViewCell: UITableViewCell {
    
    private let blockLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWithData(data: TextResponse) {
        blockLabel.text = data.text
    }
    
    private func setupSubviews() {
        contentView.addSubview(blockLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        blockLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
    }

}
