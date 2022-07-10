//
//  LockListViewController+TestHelpers.swift
//  SimonsVossTests
//
//  Created by Amir Daliri on 11.07.2022.
//

import Foundation
@testable import SimonsVoss

extension LockListViewController {
    
    func simulateUserInitiatedListReload() {
        tableView.refreshControl?.simulatePullToRefresh()
    }
    
    var isShowingLoadingIndicator: Bool {
        return tableView.refreshControl?.isRefreshing == true
    }
}
