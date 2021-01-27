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
    private var rows: [ProfileRows] = []

    let viewModel: ProfileViewModel
    weak var coordinator: ProfileCoordinator?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(TextCell.self,
                           forCellReuseIdentifier: "\(TextCell.self)")

        tableView.register(ImageCell.self,
                           forCellReuseIdentifier: "\(ImageCell.self)")
        tableView.register(ExperienceCell.self,
                           forCellReuseIdentifier: "\(ExperienceCell.self)")
        tableView.register(SocialCell.self,
                           forCellReuseIdentifier: "\(SocialCell.self)")

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

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        bind()
    }

    private func bind() {
        tableView.delegate = self
        tableView.dataSource = self

        viewModel.fetchProfile { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let rows):
                self.rows = rows
            case .failure(let error):
                self.rows = []
                print("[DEBUG] - Error happened - \(error.localizedDescription)")
            }

            self.tableView.reloadData()
        }
    }

    private func layout() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white

        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]

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

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let row = rows[indexPath.row]
        switch row {
        case .experience(let experienceDetails):
            let experienceDetailsCopy = experienceDetails.details.joined(separator: "\n")
            coordinator?.startDetails(for: experienceDetailsCopy,
                                      withTitle: "\(experienceDetails.position) - \(experienceDetails.startDate) - \(experienceDetails.endDate)")
        case .social(let socialDetails):
            guard let url = URL(string: socialDetails.path) else { return }
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        default: break
        }
    }
}
