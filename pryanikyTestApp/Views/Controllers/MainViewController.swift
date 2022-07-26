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
        setTableView()
        setupSubviews()
        startSpinner()
        feedableViewModel.startFeed(complition: { recivedCellsTypes in
            DispatchQueue.main.async { [weak self] in
                self?.feedStorage = recivedCellsTypes
                self?.tableView.reloadData()
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
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoTableViewCell")
        tableView.register(AudioTableViewCell.self, forCellReuseIdentifier: "AudioTableViewCell")
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cell = tableView.cellForRow(at: indexPath)
        print("TableView row \(indexPath.row) tapped. Here is \(cell?.reuseIdentifier ?? "")")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = feedStorage[indexPath.row]

        if feed.name == FeedMembers.text.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextOnlyTableViewCell", for: indexPath) as? TextOnlyTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            return cell
        } else if feed.name == FeedMembers.picture.rawValue {
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
        } else if feed.name == FeedMembers.selector.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VariableTableViewCell", for: indexPath) as? VariableTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            return cell
        } else if feed.name == FeedMembers.video.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            feedableViewModel.fetchImage(fromURL: feed.data.coverUrl, complition: { img in
                DispatchQueue.main.async {
                    cell.setupWithImg(img)
                }
            })

            return cell
        } else if feed.name == FeedMembers.audio.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioTableViewCell", for: indexPath) as? AudioTableViewCell else {
                return UITableViewCell()
            }
            cell.setupWithData(data: feed.data)
            feedableViewModel.fetchImage(fromURL: feed.data.coverUrl, complition: { img in
                DispatchQueue.main.async {
                    cell.setupWithImg(img)
                }
            })

            return cell
        }

        return UITableViewCell()

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rowsCount = tableView.numberOfRows(inSection: 0)
        guard rowsCount > 0, rowsCount - indexPath.row < 3 else { return }

        feedableViewModel.startFeed(complition: { recivedCellsTypes in
            DispatchQueue.main.async { [weak self] in
                self?.feedStorage += recivedCellsTypes
                self?.tableView.reloadData()
                self?.stopSpinner()
            }
        })

    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let canStoppableCell = cell as? Controllable else {
            return
        }

        canStoppableCell.stop()
    }

}
