//
//  MainViewController.swift
//  pryanikyTestApp
//
//  Created by admin on 18.07.2022.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var feedableViewModel: FeedableViewModel
    
    private var feedStorage = [CellType]()
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    private let spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setTableView()
        setupSubviews()
        startSpinner()
        feedableViewModel.startFeed(complition: { recivedCellsTypes in
            DispatchQueue.main.async { [weak self] in
                self?.feedStorage = recivedCellsTypes
                self?.tableView.reloadData()
                self?.view.backgroundColor = .blue
                self?.stopSpinner()
            }
        })
    }
    
    init(feedableViewModel: FeedableViewModel) {
        self.feedableViewModel = feedableViewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextOnlyTableViewCell.self, forCellReuseIdentifier: "TextOnlyTableViewCell")
        tableView.register(PictureTableViewCell.self, forCellReuseIdentifier: "PictureTableViewCell")
        tableView.register(VariableTableViewCell.self, forCellReuseIdentifier: "VariableTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 20
        
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func startSpinner() {
        let headerSpinner = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        spinner.startAnimating()
        spinner.color = .blue
        headerSpinner.addSubview(spinner)
        spinner.center = headerSpinner.center
        tableView.tableFooterView = headerSpinner
    }
    
    private func stopSpinner() {
        tableView.tableFooterView = nil
    }

}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedStorage.count
    }
    
    //Print something else
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        print("\(String(describing: cell))")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let feed = feedStorage[indexPath.row]
        
        if feed.name == FeedMembers.text.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextOnlyTableViewCell", for: indexPath) as? TextOnlyTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            return cell
        }
        else if feed.name == FeedMembers.picture.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureTableViewCell", for: indexPath) as? PictureTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            feedableViewModel.fetchImage(fromURL: feed.data.url, complition: { img in
                DispatchQueue.main.async {
                    cell.setupWithImg(img)
                }
            })
            return cell
        }
        else if feed.name == FeedMembers.selector.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VariableTableViewCell", for: indexPath) as? VariableTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            return cell
        }
        
        return UITableViewCell()
        
    }
        
}
