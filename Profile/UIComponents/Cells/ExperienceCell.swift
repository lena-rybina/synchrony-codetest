//
//  ExperienceCell.swift
//  Profile
//
//  Created by Ielena R. on 1/26/21.
//

import UIKit

class ExperienceCell: UITableViewCell {
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    let detailImageView: UIImageView = UIImageView()


    let paddingConst: CGFloat = 20
    let innerPaddingConst: CGFloat = 5

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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailImageView)
        

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: paddingConst),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: paddingConst),
            titleLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor,
                                                 constant: -paddingConst),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: innerPaddingConst),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: paddingConst),
            subtitleLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor,
                                                    constant: -paddingConst),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor,
                                           constant: innerPaddingConst),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: paddingConst),
            dateLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor,
                                                constant: -paddingConst),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -paddingConst)
        ])

        NSLayoutConstraint.activate([
            detailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                      constant: -paddingConst),
            detailImageView.heightAnchor.constraint(equalToConstant: 20),
            detailImageView.widthAnchor.constraint(equalTo: detailImageView.heightAnchor)
        ])
    }
}
