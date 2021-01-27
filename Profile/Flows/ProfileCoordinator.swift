//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Ielena R. on 1/26/21.
//

import UIKit
import Foundation

class ProfileCoordinator {
    var navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let model = ProfileModel()
        let viewModel = ProfileViewModel(model: model)
        let view = ProfileViewController(viewModel: viewModel)

        view.coordinator = self

        navigationController.viewControllers = [view]
    }

    func startDetails(for detailsText: String,
                      withTitle title: String) {
        let detailsVC = DetailsViewController(detailsCopy: detailsText)
        detailsVC.title = title
        navigationController.pushViewController(detailsVC,
                                                animated: true)
    }
}
