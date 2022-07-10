//
//  UIRefreshControl+TestHelpers.swift
//  SimonsVossTests
//
//  Created by Amir Daliri on 11.07.2022.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
