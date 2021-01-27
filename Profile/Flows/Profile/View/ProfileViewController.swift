//
//  ProfileViewController.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import UIKit
import Foundation
import Kingfisher

class ProfileViewController: UIViewController {
    /// Datasource
    private var rows: [ProfileRows] = []

    let viewModel: ProfileViewModel

    /// Coordinator used for starting new flows / passing actions up the stream
    /// Injected coordinator, weak in order to avoid memory leak
    weak var coordinator: ProfileCoordinator?

    /// Table view lazy init
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)

        /// Registering custom cells
        tableView.register(TextCell.self,
                           forCellReuseIdentifier: "\(TextCell.self)")
        tableView.register(ImageCell.self,
                           forCellReuseIdentifier: "\(ImageCell.self)")
        tableView.register(SocialCell.self,
                           forCellReuseIdentifier: "\(SocialCell.self)")
        tableView.register(ExperienceCell.self,
                           forCellReuseIdentifier: "\(ExperienceCell.self)")

        return tableView
    }()

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// This method is called after the view controller has loaded its view hierarchy into memory
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        bind()
    }

    /// Binding view model actions to view
    private func bind() {
        tableView.delegate = self
        tableView.dataSource = self

        /// Fetching and reloading tableView
        viewModel.fetchRows { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let rows):
                self.rows = rows
            case .failure(let error):
                /// TODO: Handle alert?
                self.rows = []
                print("[DEBUG] - Error happened - \(error.localizedDescription)")
            }

            /// Reloading tableView
            self.tableView.reloadData()
        }
    }

    /// Custom layout setup
    private func layout() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white

        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        /// Setting up layout constraint with safe layout guide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

/// TableViewDataSource conformance
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    /// Cell setup
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// Get current row
        let row = rows[indexPath.row]

        print("[DEBUG] - displaying \(indexPath)")

        /// Iterate through types
        switch row {
        case .name(let name):
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextCell.self)",
                                                     for: indexPath) as! TextCell
            cell.selectionStyle = .none
            cell.titleLabel.text = name

            return cell

        case .profileImage(let imageURL):
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageCell.self)",
                                                     for: indexPath) as! ImageCell
            /// Fetching image with KingsFisher
            cell.profileImageView.kf.setImage(with: imageURL)
            cell.selectionStyle = .none
            return cell

        case .experience(let experience) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ExperienceCell.self)",
                                                     for: indexPath) as! ExperienceCell
            cell.titleLabel.text = experience.companyName
            cell.subtitleLabel.text = experience.position
            cell.dateLabel.text = "\(experience.startDate) - \(experience.endDate)"
            cell.detailImageView.image = UIImage(systemName: "chevron.right")
            cell.selectionStyle = .none
            return cell

        case .social(let social) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(SocialCell.self)",
                                                     for: indexPath) as! SocialCell
            cell.titleLabel.text = social.name
            cell.subtitleLabel.text = social.path
            cell.subtitleLabel.textColor = .blue
            cell.selectionStyle = .none
            return cell
        }
    }
}

/// TableViewDelegate Confortance
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        print("[DEBUG] - tapped on \(indexPath)")
        /// Getting current row[
        let row = rows[indexPath.row]
        switch row {
        case .experience(let experienceDetails):
            let experienceDetailsCopy = experienceDetails.details.joined(separator: "\n")
            let titleCopy = "\(experienceDetails.position) - \(experienceDetails.startDate) - \(experienceDetails.endDate)"

            /// Triggering coordinator action
            coordinator?.startDetails(for: experienceDetailsCopy,
                                      withTitle: titleCopy)
        case .social(let socialDetails):
            guard let url = URL(string: socialDetails.path) else { return }
            /// Opening as external link
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        default: break
        }
    }
}
