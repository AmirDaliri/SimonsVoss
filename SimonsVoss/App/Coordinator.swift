//
//  Coordinator.swift
//  SimonsVoss
//
//  Created by Amir Daliri on 10.07.2022.
//

import UIKit

class Coordinator {
    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() {
        showList()
    }

    private func showList() {
        let url = LockEndPoint.lockList
        let client = URLSessionHTTPClient(session: .shared)
        let loader = RemoteDataLoader(url: url, client: client)
        let lockViewController = LockListUIComposer.composedWith(loader: loader)
        
        navigation.setViewControllers([lockViewController], animated: false)
    }
}
