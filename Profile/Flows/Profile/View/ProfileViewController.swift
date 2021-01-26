//
//  ProfileViewController.swift
//  Profile
//
//  Created by Ielena R. on 1/25/21.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController {
    private var rows: [ProfileRows] = []

    let viewModel: ProfileViewModel

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)


        collectionView.alwaysBounceVertical = true
        collectionView.register(TextCell.self,
                                forCellWithReuseIdentifier: "\(TextCell.self)")

        return collectionView
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
        collectionView.delegate = self
        collectionView.dataSource = self

        viewModel.fetchProfile { [weak self] rows in
            guard let self = self else { return }

            self.rows = rows
            self.collectionView.reloadData()
        }
    }

    private func layout() {
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: 80)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        rows.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TextCell.self)", for: indexPath) as! TextCell

        let row = rows[indexPath.row]
        switch row {
        case .name(let name):
            cell.titleLabel.text = name
        default: break
        }

        cell.backgroundColor = .red

        return cell
    }
}
