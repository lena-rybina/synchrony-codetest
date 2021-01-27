//
//  ImageCell.swift
//  Profile
//
//  Created by Ielena R. on 1/26/21.
//

import UIKit

class ImageCell: UITableViewCell {
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImageView)

        let heightAnchor: NSLayoutConstraint = profileImageView.heightAnchor.constraint(equalToConstant: 120)
        heightAnchor.priority = .defaultHigh

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                  constant: 20),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                     constant: -20),
            heightAnchor,
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: -15)
        ])
    }
}
