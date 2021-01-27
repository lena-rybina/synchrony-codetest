//
//  DetailsViewController.swift
//  Profile
//
//  Created by Ielena R. on 1/26/21.
//

import UIKit
import Foundation

class DetailsViewController: UIViewController {
    let detailsCopy: String
    let detailsTextView = UITextView()

    init(detailsCopy: String) {
        self.detailsCopy = detailsCopy
        super.init(nibName: nil,
                   bundle: nil)

        detailsTextView.text = detailsCopy
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func layout() {
        view.backgroundColor = .white
        view.addSubview(detailsTextView)

        detailsTextView.alwaysBounceVertical = true
        detailsTextView.translatesAutoresizingMaskIntoConstraints = false

        detailsTextView.font = UIFont.boldSystemFont(ofSize: 18)

        NSLayoutConstraint.activate([
            detailsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 20),
            detailsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -20),
            detailsTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
