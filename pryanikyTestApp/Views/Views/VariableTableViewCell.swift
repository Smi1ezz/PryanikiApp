//
//  VariableTableViewCell.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import UIKit

class VariableTableViewCell: UITableViewCell {
        
    private var storage: VariantsResponse? {
        didSet {
            picker.reloadAllComponents()
        }
    }
    
    private let picker: UIPickerView = {
       let picker = UIPickerView()
        return picker
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        picker.dataSource = self
        picker.delegate = self
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//        Else we can fix it here
    override func prepareForReuse() {
//        picker.reloadAllComponents()
    }
    
    func setupWithData(data: VariantsResponse) {
        storage = data
    }
    
    private func setupSubviews() {
        contentView.addSubview(picker)
        setupConstraints()
    }
    
    private func setupConstraints() {
        picker.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)

        }
    }
}

extension VariableTableViewCell: UIPickerViewDelegate {
    
}

extension VariableTableViewCell: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("picker row \(row) selected")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return storage?.variants?.count ?? 3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if storage?.selectedID == storage?.variants![row].id {
            picker.selectRow(Int(row), inComponent: 0, animated: true)
        }
        return storage?.variants?[row].text ?? "none"
    }
    
}
