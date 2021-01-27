//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Ielena R. on 1/26/21.
//

import UIKit
import Foundation

class ProfileCoordinator {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts coordinator and creates MVVM flow
    func start() {
        let model = ProfileModel()
        let viewModel = ProfileViewModel(model: model)
        let view = ProfileViewController(viewModel: viewModel)

        /// Injecting coordinator for starting new flows
        view.coordinator = self

        /// Setting up initial navigation stack
        navigationController.viewControllers = [view]
    }

    /// Starts details flow
    func startDetails(for detailsText: String,
                      withTitle title: String) {
        let detailsVC = DetailsViewController(detailsCopy: detailsText)
        detailsVC.title = title
        navigationController.pushViewController(detailsVC,
                                                animated: true)
    }
}
